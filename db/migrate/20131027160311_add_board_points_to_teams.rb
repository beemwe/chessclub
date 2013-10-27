class AddBoardPointsToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :board_points, :string
    add_column :teams, :board_points_plus, :decimal, precision: 5, scale: 1
    add_column :teams, :board_points_minus, :decimal, precision: 5, scale: 1
    add_column :teams, :results_hash, :text
  end
end
