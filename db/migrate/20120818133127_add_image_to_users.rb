class AddImageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_column :users, :avatar_uid, :string
    add_column :users, :avatar_name, :string
  end
end
