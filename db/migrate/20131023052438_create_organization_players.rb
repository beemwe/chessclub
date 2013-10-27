class CreateOrganizationPlayers < ActiveRecord::Migration
  def change
    create_table :organization_players do |t|
      t.string :index
      t.string :first_name
      t.string :last_name
      t.string :fide_title
      t.integer :pkz
      t.integer :status
      t.integer :bitrh_year
      t.integer :dwz
      t.integer :elo
      t.string :club
      t.integer :club_id
      t.integer :dewis_club_id

      t.timestamps
    end
    add_index :organization_players, :index
  end
end
