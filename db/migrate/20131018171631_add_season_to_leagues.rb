class AddSeasonToLeagues < ActiveRecord::Migration
  def change
    add_column :leagues, :season, :string
  end
end
