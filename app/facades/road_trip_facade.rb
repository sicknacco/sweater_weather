class RoadTripFacade
  def self.get_trip(origin, destination)
    directions = MapService.get_directions(origin, destination)
    travel_time = directions[:route][:formattedTime]
    dest_lat = directions[:route][:locations][1][:latLng][:lat]
    dest_lng = directions[:route][:locations][1][:latLng][:lng]

    arrival_time = Time.now + travel_time.to_i
    formatted_arv_time = arrival_time.strftime('%Y-%m-%d %H:%M')
    forecast = WeatherService.daily_weather(dest_lat, dest_lng)

    forecast[:forecast][:forecastday].map do |day|
      next unless arrival_time.to_s.include?(day[:date])
      @arrival_forecast = {
        datetime: formatted_arv_time,
        temperature: day[:hour][arrival_time.hour][:temp_f],
        condition: day[:hour][arrival_time.hour][:condition][:text]
      }
    end
    RoadTrip.new(origin, destination, travel_time, @arrival_forecast)
  end
end