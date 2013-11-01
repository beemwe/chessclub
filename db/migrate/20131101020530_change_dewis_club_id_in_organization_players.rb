class ChangeDewisClubIdInOrganizationPlayers < ActiveRecord::Migration
  def up
    change_column :organization_players, :dewis_club_id, :string, limit: 5
  end

  def down
    change_column :organization_players, :dewis_club_id, :integer
  end
end
