class AddClubPropertiesToUser < ActiveRecord::Migration
  def change
    add_column :users, :last_name, :string
    add_column :users, :first_name, :string
    add_column :users, :birth_date, :date
    add_column :users, :member_since, :date
    add_column :users, :dwz, :integer
    add_column :users, :title, :string
  end
end
