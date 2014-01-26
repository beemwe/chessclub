json.(@league, :id, :name)

json.ranking_list do |json|
    json.array! @teams, :id, :name, :position, :points, :board_points
end