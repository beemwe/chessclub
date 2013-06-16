class AddRegistrarToTournamentPlayers < ActiveRecord::Migration
  def change
    add_column :tournament_players, :registrar, :string
  end
end
