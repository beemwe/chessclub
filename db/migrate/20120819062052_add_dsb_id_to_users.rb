class AddDsbIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :dsb_id, :string
  end
end
