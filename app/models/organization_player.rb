class OrganizationPlayer < ActiveRecord::Base
  # set_primary_key :index
  attr_accessible :birth_year, :club, :club_id, :dewis_club_id, :dwz, :elo, :fide_title, :first_name, :last_name, :pkz,
                  :status, :gender

  has_many :team_players
  # has_many :teams, through: :team_players

  before_save :set_index_and_club_data


  private
  def set_index_and_club_data
    self.status = 'A' if self.status.blank?
    self.index = self.club_id.to_s + self.pkz.to_s + self.status
    club = Club.find_by_zps self.dewis_club_id
    self.club_id = club.id
    self.club = club.name
  end
end
