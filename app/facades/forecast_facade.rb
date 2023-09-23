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
    
    daily = WeatherService.daily_weather(lat, lon)
    dw = daily[:forecast][:forecastday].map do |day|
      {
        date: day[:date],
        sunrise: day.dig(:astro, :sunrise),
        sunset: day.dig(:astro, :sunset),
        max_temp: day.dig(:day, :maxtemp_f),
        min_temp: day.dig(:day, :mintemp_f),
        condition: day.dig(:day, :condition, :text),
        icon: day.dig(:day, :condition, :icon)
      }
    end
   
    hourly = WeatherService.hourly_weather(lat, lon)
    hw = hourly[:forecast][:forecastday][0][:hour].map do |hour|
      {
        time: hour[:time],
        temperature: hour[:temp_f],
        condition: hour.dig(:condition, :text),
        icon: hour.dig(:condition, :icon)
      }
    end

    Forecast.new(cw, dw, hw)
  end
end