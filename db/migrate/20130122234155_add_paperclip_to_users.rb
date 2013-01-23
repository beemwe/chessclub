class AddPaperclipToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :avatar_name
    remove_column :users, :avatar_uid
    add_attachment :users, :avatar
  end
end
