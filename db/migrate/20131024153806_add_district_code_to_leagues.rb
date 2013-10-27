class AddDistrictCodeToLeagues < ActiveRecord::Migration
  def change
    add_column :leagues, :district_code, :integer
  end
end
