json.array! @leagues do |league|
  json.(league, :id, :name)
  json.url api_v1_league_url(league)
end