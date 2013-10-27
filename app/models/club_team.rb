class ClubTeam < ActiveRecord::Base
  belongs_to :club
  belongs_to :team
  # attr_accessible :title, :body
end
