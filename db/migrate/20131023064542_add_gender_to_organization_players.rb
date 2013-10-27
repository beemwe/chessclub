class AddGenderToOrganizationPlayers < ActiveRecord::Migration
  def change
    add_column :organization_players, :gender, :string
  end
end
