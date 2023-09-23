class ForecastFacade
  def self.get_forecast(location)
    lat_lon = MapService.city_coordinates(location)
    lat = lat_lon[:results][0][:locations][0][:latLng][:lat]
    lon = lat_lon[:results][0][:locations][0][:latLng][:lng]
    
    current = WeatherService.current_weather(lat, lon)
    cw = {
      last_updated: current.dig(:current, :last_updated),
      temperature: current.dig(:current, :temp_f),
      feels_like: current.dig(:current, :feelslike_f),
      humidity: current.dig(:current, :humidity),
      uvi: current.dig(:current, :uv),
      visibility: current.dig(:current, :vis_miles),
      condition: current.dig(:current, :condition, :text),
      icon: current.dig(:current, :condition, :icon)
    }
    
    hourly = WeatherService.hourly_weather(lat, lon)
    hw =
  end
end