class AddTeamIdToClubs < ActiveRecord::Migration
  def change
    add_column :clubs, :team_id, :integer
  end
end
