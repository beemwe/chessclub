class Club < ActiveRecord::Base
  attr_accessible :name, :zps

  has_many :club_teams
  has_many :teams, through: :club_teams
end
