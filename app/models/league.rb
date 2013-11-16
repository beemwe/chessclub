# encoding: utf-8
class League < ActiveRecord::Base
  include ::Transitions
  include ActiveRecord::Transitions

  attr_accessible :age_limit, :boards, :girls_only, :name, :scraper_link, :subs_bench, :teams, :gaming_days, :season,
                  :district_code, :combatdays_attributes, :teams_attributes, :team_players_attributes, :combats_attributes,
                  :kick_off, :durance

  has_many :combatdays, :dependent => :destroy
  accepts_nested_attributes_for :combatdays, :reject_if => :reject_combat_days, :allow_destroy => true
  has_many :teams, :dependent => :destroy
  accepts_nested_attributes_for :teams, :reject_if => :reject_teams, :allow_destroy => true
  has_many :team_players
  accepts_nested_attributes_for :team_players, :reject_if => :reject_team_players, :allow_destroy => true
  has_many :combats
  accepts_nested_attributes_for :combats, :reject_if => :reject_combats, :allow_destroy => true


  serialize :teams, Array
  serialize :gaming_days, Array

  after_initialize :init_fields

  before_save :calculate_team_ranking

  CLUBNAME = 'TuS Fürstenfeldbruck'

  state_machine do
    state :preparation
    state :team_announcement
    state :planning
    state :execution
    state :deletion

    event :finish_preparation do
      transitions to: :team_announcement, from: [:preparation]
    end

    event :finish_announcement do
      transitions to: :planning, from: [:team_announcement], on_transition: :do_planning_prerequisites
    end

    event :rollback_planning do
      transitions to: :team_announcement, from: [:planning]
    end

    event :start_season do
      transitions to: :execution, from: [:planning]
    end

  end

  def init_fields
    self.age_limit |= 0
  end

  def state_name
    I18n.t("leagues.state.#{self.state}")
  end

  def state?(state)
    self.state.to_sym == state
  end

  def generate_team_name
    addition = ''

    use_age_limit = self.age_limit || 0
    if use_age_limit == 0
      addition = self.girls_only? ? ' Damen' : ''
    elsif use_age_limit > 59
      addition = self.girls_only? ? 'Seniorinnen' : 'Senioren'
    elsif use_age_limit < 22
      addition = "U#{age_limit}#{self.girls_only? ? ' Mädchen' : ''}"
    end

    "#{CLUBNAME}#{addition}"
  end

  def reject_combat_days(attributed)
    attributed['title'].blank? || attributed['combat_date'].blank?
  end

  def reject_teams(attributed)
    attributed['name'].blank?
  end

  def reject_team_players(attributed)
    result = attributed[:organization_player_id].blank? || attributed[:team_id].blank? || attributed[:league_id].blank?
    # logger.info "Spieler mit ID #{attributed[:organization_player_id]} wurde #{result ? 'abgelehnt' : 'angenommen'}."
    result
  end

  def reject_combats(attributed)
    if self.state?(:execution)
      result = false
      logger.info "Combat mit ID #{attributed[:combat_id]} wurde #{result ? 'abgelehnt' : 'angenommen'}."
    else
      result = attributed[:home_team_id].blank? || attributed[:guest_team_id].blank? || attributed[:home_team_name].blank? || attributed[:guest_team_name].blank?
      logger.info "Combat mit ID #{attributed[:combat_id]} wurde #{result ? 'abgelehnt' : 'angenommen'}."
    end
    result
  end

  def get_team_player(team_id, board_position)
    tp = TeamPlayer.where(team_id: team_id, league_id: self.id, board_position: board_position).first
    tp.present? ? tp.organization_player : nil
  end

  def get_all_team_player(team_id)
    TeamPlayer.where(team_id: team_id, league_id: self.id).order(:board_position)
  end

  def get_open_combats
    Combat.joins(:combatday).where('events.league_id = ? AND events.starttime < ?', self.id, Time.now)
  end

  def calculate_team_ranking
    teams = self.teams
    teams.each do |t|
      t.points = 0
      t.board_points = ''
      t.board_points_plus = 0
      t.board_points_minus = 0
      t.results_hash = Hash.new
    end
    combats = self.combats

    combats.each do |combat|
      unless combat.result.blank?
        result = combat.result.split ':'
        home_team_points = 0
        guest_team_points = 0
        home_board_points = result[0].gsub(/½/, '.5').to_f
        guest_board_points = result[1].gsub(/½/, '.5').to_f
        if home_board_points > guest_board_points
          if home_board_points >= self.boards / 2
            home_team_points = 3
          else
            home_team_points = 2
          end
          guest_team_points = 0
        elsif home_board_points < guest_board_points
          if guest_board_points >= self.boards / 2
            guest_team_points = 3
          else
            guest_team_points = 2
          end
          home_team_points = 0
        elsif (home_board_points == guest_board_points) && (home_board_points == self.boards / 2)
          home_team_points = 1
          guest_team_points = 1
        end

        team = teams.find { |t| t.id == combat.home_team_id }
        team.set_results(home_team_points, home_board_points, guest_board_points, combat.guest_team_id)

        team = teams.find { |t| t.id == combat.guest_team_id }
        team.set_results(guest_team_points, guest_board_points, home_board_points, combat.home_team_id)

      end
    end
    true
  end

  def get_ranked_teams
    teams.sort_by { |t| [-t.points, -t.board_points_plus, t.board_points_minus] }
  end


  private
  def do_planning_prerequisites
    Rails::logger.info "  Anzahl Spieltage: #{self.combatdays.count}"
    self.combatdays.each do |combatday|
      (self.teams.count / 2).times do |combat|
        Combat.create league_id: self.id, combat_day_id: combatday.id
      end
    end
  end


end
