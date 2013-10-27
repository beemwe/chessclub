class AddKickOffToLeagues < ActiveRecord::Migration
  def change
    add_column :leagues, :kick_off, :string
    add_column :leagues, :durance, :decimal, precision: 5, scale: 2
  end
end
