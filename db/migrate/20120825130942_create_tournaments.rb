class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.string :title
      t.string :modus
      t.string :rounds
      t.string :state
      t.string :referee

      t.timestamps
    end
  end
end
