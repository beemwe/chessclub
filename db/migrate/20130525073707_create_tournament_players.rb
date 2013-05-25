class CreateTournamentPlayers < ActiveRecord::Migration
  def change
    create_table :tournament_players do |t|
      t.references :tournament
      t.string :first_name
      t.string :last_name
      t.string :fide_title
      t.string :dwz

      t.timestamps
    end
  end
end
