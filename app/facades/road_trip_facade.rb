class RoadTripFacade
  def self.get_trip(origin, destination)
    directions = MapService.get_directions(origin, destination)
    if directions[:route].has_key?(:routeError)
      RoadTrip.new(origin, destination, 'impossible route', {})
    else
      dest_lat = directions[:route][:locations][1][:latLng][:lat]
      dest_lng = directions[:route][:locations][1][:latLng][:lng]
      
      travel_time = directions[:route][:realTime]
      arrival_time = Time.now + travel_time
      formatted_arv_time = arrival_time.strftime('%Y-%m-%d %H:%M')
      formatted_trvl_time = directions[:route][:formattedTime]
      
      forecast = WeatherService.daily_weather(dest_lat, dest_lng)
      
      forecast[:forecast][:forecastday].map do |day|
        next unless arrival_time.to_s.include?(day[:date])
        @arrival_forecast = {
          datetime: formatted_arv_time,
          temperature: day[:hour][arrival_time.hour][:temp_f],
          condition: day[:hour][arrival_time.hour][:condition][:text]
        }
      end
      RoadTrip.new(origin, destination, formatted_trvl_time, @arrival_forecast)
    end
  end
end