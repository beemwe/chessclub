class CreateClubTeams < ActiveRecord::Migration
  def change
    create_table :club_teams do |t|
      t.references :club
      t.references :team

      t.timestamps
    end

    add_index :club_teams, :club_id
    add_index :club_teams, :team_id
  end
end
