class AddTeamsToLeague < ActiveRecord::Migration
  def change
    add_column :leagues, :teams, :text
    add_column :leagues, :gaming_days, :text
    add_column :leagues, :state, :string
  end
end
