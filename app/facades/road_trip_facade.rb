class RoadTripFacade
  def self.get_trip(origin, destination)
    directions = MapService.get_directions(origin, destination)
    dest_lat = directions[:route][:locations][1][:latLng][:lat]
    dest_lng = directions[:route][:locations][1][:latLng][:lng]
    forecast = WeatherService.daily_weather(dest_lat, dest_lng)

    RoadTrip.new(origin, destination, directions, forecast)
  end
end