class AddColumnsForTreeToLeagues < ActiveRecord::Migration
  def change
    add_column :leagues, :parent_id, :integer
    add_column :leagues, :lft, :integer
    add_column :leagues, :rgt, :integer
    add_column :leagues, :depth, :integer
  end
end
