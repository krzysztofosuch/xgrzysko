json.array!(@players) do |player|
  json.extract! player, :id, :name, :uniq_hash
  json.url player_url(player, format: :json)
end
