class ChangeZpsInClubs < ActiveRecord::Migration
  def up
    change_column :clubs, :zps, :string, limit: 5
  end

  def down
    change_column :clubs, :zps, :integer
  end
end
