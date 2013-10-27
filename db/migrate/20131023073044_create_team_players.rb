class CreateTeamPlayers < ActiveRecord::Migration
  def change
    create_table :team_players do |t|
      t.references :team
      t.references :organization_player
      t.text :results
      t.float :points

      t.timestamps
    end
    add_index :team_players, :team_id
    add_index :team_players, :organization_player_id
  end
end
