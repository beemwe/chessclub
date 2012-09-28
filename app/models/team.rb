# encoding:utf-8
class Team < ActiveRecord::Base
  attr_accessible :age_limit, :board_count, :gender, :league, :name, :subs_bench, :season, :leader_id

  include ::Transitions
  include ActiveRecord::Transitions

  belongs_to :leader, :class_name => 'User'

  before_create :set_name_from_attributes

  ROMAN_NUMBERS = %w(I II III IV V VI VII VIII IX X XII XIII XIV XV)

  state_machine do
    state :created
    state :team_announced
    state :season_started
    state :finished
    state :archived

    event :announce_team do
      transitions :to => :team_announced, :from => [:created]
    end
    event :board_report do
      transitions :to => :board_report, :from => [:team_reported]
    end
    event :start_season do
      transitions :to => :season_started, :from => [:board_reported]
    end
    event :archive do
      transitions :to => :archived, :from => [:season_started]
    end
  end

  def state_name
    case self.state
      when 'created'
        result = "nicht gemeldet"
      when 'team_announced'
        result = "keine Brettfolge gemeldet"
      when 'season_started'
        result = "Saison läuft"
      when 'finished'
        result = "Saison abgeschlossen"
      when 'archived'
        result = "archiviert"
    end
    result
  end

  def self.actives
    Team.where{state != 'archived'}
  end
  def self.archive
    Team.where{state == 'archived'}
  end

  protected

  def set_name_from_attributes
    used_season = self.season
    used_id = self.id
    used_gender = self.gender || '0'
    used_age_limit = self.age_limit || ''
    others = Team.where{(season == used_season) & (id != used_id) & (age_limit == used_age_limit) & (gender == used_gender)}

    if used_age_limit == "Senioren"
      addition = used_gender == '0' ? " #{used_age_limit}" : " Seniorinnen"
    elsif used_age_limit != ""
      addition = " #{used_age_limit}#{used_gender == '0' ? '' : ' Mädchen'}"
    else
      addition = used_gender == '0' ? '' : ' Damen'
    end

    lfd = others.count > 0 ? " #{ROMAN_NUMBERS[others.count]}" : ""
    self.name = "TuS Fürstenfeldbruck#{addition}#{lfd}"
  end
end
