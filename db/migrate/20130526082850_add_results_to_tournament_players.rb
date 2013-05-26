class AddResultsToTournamentPlayers < ActiveRecord::Migration
  def change
    add_column :tournament_players, :result, :text
  end
end
