class TeamPlayer < ActiveRecord::Base
  # belongs_to :team
  belongs_to :organization_player
  belongs_to :league

  attr_accessible :organization_player_id, :team_id, :league_id, :points, :results, :board_position

  serialize :results, Array
end
