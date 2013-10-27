class AlterBrithYearInOrganizationPlayers < ActiveRecord::Migration
  def up
    rename_column :organization_players, :bitrh_year, :birth_year
    change_column :organization_players, :status, :string
  end

  def down
    rename_column :organization_players, :birth_year, :bitrh_year
    change_column :organization_players, :status, :integer
  end
end
