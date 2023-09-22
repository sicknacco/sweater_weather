require 'rails_helper'

RSpec.describe WeatherService do
  describe 'weather_forecast' do
    it 'returns weather data for a given coordinates', :vcr do
      weather = WeatherService.current_weather(39.74001, -104.99202)

      expect(weather).to be_a(Hash)
    end
  end
end