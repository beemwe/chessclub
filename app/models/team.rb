# encoding:utf-8
class Team < ActiveRecord::Base
  belongs_to :leader, :class_name => 'User'
  belongs_to :league

  has_many :club_teams
  has_many :clubs,  through: :club_teams

  has_many :organization_players, through: :team_players

  attr_accessible :league_id, :name, :dewis_club_id, :club_ids, :results_hash

  extend FriendlyId
  friendly_id :name, :use => [:slugged, :history]


  serialize :results_hash

  ROMAN_NUMBERS = %w(I II III IV V VI VII VIII IX X XII XIII XIV XV)

  def self.club_selection(district_code)
    start_id = 0
    end_id = 0
    if district_code.blank?
      start_id = 0
      end_id =  0
    elsif district_code < 100
      start_id = district_code * 1000
      end_id =  start_id + 999
    elsif district_code < 1000
      start_id = district_code * 100
      end_id = start_id + 99
    end
    Club.where('zps BETWEEN ? AND ?', start_id, end_id).map{|c| [c.name, c.id]}
  end

  def player_selection
    OrganizationPlayer.where(dewis_club_id: self.clubs.map{|c| c.zps}).order('last_name, first_name').map{|op| ["#{op.fide_title}#{' ' if op.fide_title.present?}#{op.last_name}, #{op.first_name} #{op.dwz}", op.id]}
  end

  protected

  def set_name_from_attributes
    used_season = self.season
    used_id = self.id
    used_gender = self.gender || '0'
    used_age_limit = self.age_limit || ''
    others = Team.where{(season == used_season) & (id != used_id) & (age_limit == used_age_limit) & (gender == used_gender)}

    if used_age_limit == 'Senioren'
      addition = used_gender == '0' ? " #{used_age_limit}" : ' Seniorinnen'
    elsif used_age_limit != ""
      addition = " #{used_age_limit}#{used_gender == '0' ? '' : ' Mädchen'}"
    else
      addition = used_gender == '0' ? '' : ' Damen'
    end

    lfd = others.count > 0 ? " #{ROMAN_NUMBERS[others.count]}" : ''
    self.name = "TuS Fürstenfeldbruck#{addition}#{lfd}"
  end



  def self.actives
    Team.joins(:league).where('LOWER(teams.name) LIKE "tus fürstenfeldbruck%" AND leagues.state != "deletion"').order(:name)
  end

  def self.archive
    Team.joins(:league).where('LOWER(teams.name) LIKE "tus fürstenfeldbruck%" AND leagues.state = "deletion"').order('season DESC, name ASC')
  end

end
