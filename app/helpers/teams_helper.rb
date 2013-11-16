module TeamsHelper
  def combat_report_link( combat, home = true)
    if home
      if combat.home_team_id.present?
        result = link_to combat.home_team_name, team_path(combat.home_team_id)
      else
        result = combat.home_team_name
      end
    else
      if combat.guest_team_id.present?
        result = link_to combat.guest_team_name, team_path(combat.guest_team_id)
      else
        result = combat.guest_team_name
      end
    end
    result
  end

end
