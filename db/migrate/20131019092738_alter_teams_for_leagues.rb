class AlterTeamsForLeagues < ActiveRecord::Migration
  def up
    drop_table :teams
    create_table :teams do |t|
      t.string :name
      t.integer :league_id
      t.integer :position
      t.decimal :points

      t.timestamps
    end
  end

  def down
    drop_table :teams
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
