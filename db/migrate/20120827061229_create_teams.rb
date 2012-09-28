class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :board_count
      t.integer :subs_bench
      t.string :league
      t.string :gender
      t.string :age_limit
      t.string :state
      t.string :season

      t.timestamps
    end
  end
end
