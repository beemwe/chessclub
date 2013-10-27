class AddLeagueIdToTeamPlayer < ActiveRecord::Migration
  def change
    add_column :team_players, :league_id, :integer
  end
end
