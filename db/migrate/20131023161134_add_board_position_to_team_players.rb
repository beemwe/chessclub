class AddBoardPositionToTeamPlayers < ActiveRecord::Migration
  def change
    add_column :team_players, :board_position, :integer
  end
end
