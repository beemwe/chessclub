json.(@league, :id, :name)

json.combatdays @league.combatdays do |combatday|
    json.starting combatday.combat_date
    json.combats do
        json.array! combatday.combats do |combat|
            json.(combat, :id) #, :home_team_name, :guest_team_name, :result)
        end
    end
end

json.ranking_list do
    json.array! @teams, :id, :name, :position, :points, :board_points
end

