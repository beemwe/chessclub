class AddDewisClubIdToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :dewis_club_id, :integer
  end
end
