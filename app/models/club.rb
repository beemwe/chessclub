class Club < ActiveRecord::Base
  attr_accessible :name, :zps, :country_organization, :county_organization

  has_many :club_teams
  has_many :teams, through: :club_teams

  def self.generate_from_dewis(csv)
    data_rec = csv.gsub(/"/, '').split ','
    zps = data_rec[0]
    club = Club.find_or_initialize_by_zps(zps)
    club.update_attributes country_organization: data_rec[1], county_organization: data_rec[2], name: data_rec[3]
    club
  end

end
