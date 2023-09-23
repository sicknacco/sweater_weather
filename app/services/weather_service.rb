class WeatherService

  def self.current_weather(lat, lon)
    get_url("/v1/current.json?q=#{lat},#{lon}")
  end

  def self.daily_weather(lat, lon)
    get_url("/v1/forecast.json?q=#{lat},#{lon}&days=5")
  end
  private

  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn 
    Faraday.new(url: 'http://api.weatherapi.com') do |f|
      f.params['key'] = Rails.application.credentials.weather[:WEATHER_API_key]
    end
  end
end