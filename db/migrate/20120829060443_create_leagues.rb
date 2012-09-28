class CreateLeagues < ActiveRecord::Migration
  def change
    create_table :leagues do |t|
      t.string :name
      t.string :scraper_link
      t.integer :boards
      t.integer :subs_bench
      t.integer :age_limit
      t.boolean :girls_only

      t.timestamps
    end
  end
end
