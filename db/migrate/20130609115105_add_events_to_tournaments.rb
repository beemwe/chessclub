class AddEventsToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :events, :text
  end
end
