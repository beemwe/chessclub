class ModifyOmbatDayIdInCombat < ActiveRecord::Migration
  def change
    rename_column :combats, :combat_day_id, :combatday_id
  end
end
