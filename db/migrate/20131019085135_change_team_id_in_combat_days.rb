class ChangeTeamIdInCombatDays < ActiveRecord::Migration
  def up
    rename_column :events, :team_id, :league_id
  end

  def down
    rename_column :events, :league_id, :team_id
  end
end
