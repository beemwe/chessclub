# encoding:utf-8
#noinspection ALL
class Tournament < ActiveRecord::Base
  include ::Transitions
  include ActiveRecord::Transitions

  has_many :tournament_players, dependent: :destroy
  accepts_nested_attributes_for :tournament_players, :reject_if => :all_blank, :allow_destroy => true

  attr_accessible :modus, :rounds, :state, :title, :referee, :tournament_players_attributes, :rules, :invitation, :registrar
  validates_presence_of :title, :modus

  attr_accessor :ranking_list
  attr_accessor :registrar

  serialize :events, Hash

  MODI = [%w(Rutschsystem EasyRobinRound), %w(Vollrundensystem RobinRound), ['doppelrund. Vollsystem', 'DoubleRobinRound'], ['K.O. System', 'KoSystem'], ['K.O. System m. Trostrunde', 'KoSystem+'], ['Schweizer System', 'SwissSystem']]

  state_machine do
    state :in_preparation
    state :running
    state :finished
    state :archived

    event :run do
      transitions :to => :running, :from => [:in_preparation]
    end
    event :finish do
      transitions :to => :finished, :from => [:running]
    end
    event :archive do
      transitions :to => :archived, :from => [:running, :finished]
    end

  end

  def state_name
    case self.state
      when 'in_preparation'
        result = 'In Vorbereitung'
      when 'running'
        result = 'läuft'
      when 'finished'
        result = 'Abgeschlossen'
      when 'archived'
        result = 'archiviert'
      else
        result = 'unbekannter Status'
    end
    result
  end

  def self.actives
    Tournament.where{state != 'archived'}
  end

  def self.archive
    Tournament.where{state == 'archived'}
  end

  def registered_players
    self.tournament_players.where(registrar: 'Bernd M. Walter')
  end

  def make_players_start_list
    self.tournament_players.map{|player| ["#{player.fide_title.blank? ? '' : player.fide_title + ' '}#{player.first_name} #{player.last_name}", player.dwz]}
  end

  def make_ranking_list
    ranking_list || make_table_array
  end

  def make_table_array
    buffer = self.tournament_players.map{|p| [p.id, "#{p.first_name} #{p.last_name}", p.result[:points], p.result[:place].blank? ? 1 : p.result[:place]]}.sort_by{|p| -p[2]}
    points = buffer[0][2]
    place = 1
    buffer.each do |p|
      if p[2] < points
        place += 1
        points = p[2]
      end
      p[3] = place
      player = TournamentPlayer.find p[0]
      if player.result[:place] != place
        new_result = player.result
        new_result[:place] = place
        player.update_attribute :result, new_result
      end
    end

    self.ranking_list = buffer.sort_by{|p| p[0]}
  end

end
