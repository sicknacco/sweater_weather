require 'rails_helper'

RSpec.describe WeatherService do
  describe 'weather_forecast' do
    it 'returns weather data for a given coordinates', :vcr do
      weather = WeatherService.current_weather(39.74001, -104.99202)

      expect(weather).to be_a(Hash)
      expect(weather[:location]).to be_a(Hash)
      expect(weather[:location]).to have_key(:name)
      expect(weather[:location][:name]).to be_a(String)
      expect(weather[:current]).to be_a(Hash)
      expect(weather[:current]).to have_key(:last_updated)
      expect(weather[:current][:last_updated]).to be_a(String)
      expect(weather[:current]).to have_key(:temp_f)
      expect(weather[:current][:temp_f]).to be_a(Float)
      expect(weather[:current]).to have_key(:condition)
      expect(weather[:current][:condition]).to be_a(Hash)
      expect(weather[:current][:condition]).to have_key(:text)
      expect(weather[:current][:condition][:text]).to be_a(String)
      expect(weather[:current][:condition]).to have_key(:icon)
      expect(weather[:current][:condition][:icon]).to be_a(String)
      expect(weather[:current]).to have_key(:humidity)
      expect(weather[:current][:humidity]).to be_an(Integer)
      expect(weather[:current]).to have_key(:feelslike_f)
      expect(weather[:current][:feelslike_f]).to be_a(Float)
      expect(weather[:current]).to have_key(:vis_miles)
      expect(weather[:current][:vis_miles]).to be_a(Float)
      expect(weather[:current]).to have_key(:uv)
      expect(weather[:current][:uv]).to be_a(Float)
    end
  end
end