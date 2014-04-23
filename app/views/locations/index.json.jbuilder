json.array!(@locations) do |location|
  json.extract! location, :id, :address, :latitude, :longitude, :user_id
  json.url location_url(location, format: :json)
end
