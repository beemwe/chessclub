class CreateCombats < ActiveRecord::Migration
  def change
    create_table :combats do |t|
      t.integer :league_id
      t.integer :combat_day_id
      t.integer :home_team_id
      t.integer :guest_team_id
      t.string :home_team_name
      t.string :guest_team_name
      t.string :homeboard_1
      t.string :homeboard_2
      t.string :homeboard_3
      t.string :homeboard_4
      t.string :homeboard_5
      t.string :homeboard_6
      t.string :homeboard_7
      t.string :homeboard_8
      t.string :guestboard_1
      t.string :guestboard_2
      t.string :guestboard_3
      t.string :guestboard_4
      t.string :guestboard_5
      t.string :guestboard_6
      t.string :guestboard_7
      t.string :guestboard_8
      t.string :result
      t.string :result_1
      t.string :result_2
      t.string :result_3
      t.string :result_4
      t.string :result_5
      t.string :result_6
      t.string :result_7
      t.string :result_8

      t.timestamps
    end
  end
end
