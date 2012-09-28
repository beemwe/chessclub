class AddPersonalDataToUsers < ActiveRecord::Migration
  def change
    add_column :users, :address, :string
    add_column :users, :zip, :string
    add_column :users, :location, :string
    add_column :users, :phone, :string
    add_column :users, :mobile, :string
    add_column :users, :gender, :string
    add_column :users, :status, :string
  end
end
