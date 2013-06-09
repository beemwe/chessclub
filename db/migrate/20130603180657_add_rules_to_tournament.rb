class AddRulesToTournament < ActiveRecord::Migration
  def change
    add_column :tournaments, :rules, :text
    add_column :tournaments, :invitation, :text
  end
end
