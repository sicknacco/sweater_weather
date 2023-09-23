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
    
    it 'returns daily weather data for next 5 days', :vcr do
      weather = WeatherService.daily_weather(39.74001, -104.99202)

      expect(weather).to be_a(Hash)
      expect(weather[:forecast]).to be_a(Hash)
      expect(weather[:forecast]).to have_key(:forecastday)
      expect(weather[:forecast][:forecastday]).to be_a(Array)

      expect(weather[:forecast][:forecastday].count).to eq(5)

      weather[:forecast][:forecastday].each do |day|
        expect(day).to be_a(Hash)
        expect(day).to have_key(:date)
        expect(day[:date]).to be_a(String)
        expect(day[:day]).to be_a(Hash)
        expect(day[:day]).to have_key(:maxtemp_f)
        expect(day[:day][:maxtemp_f]).to be_a(Float)
        expect(day[:day]).to have_key(:mintemp_f)
        expect(day[:day][:mintemp_f]).to be_a(Float)

        expect(day[:day]).to have_key(:condition)
        expect(day[:day][:condition]).to be_a(Hash)
        expect(day[:day][:condition]).to have_key(:text)
        expect(day[:day][:condition][:text]).to be_a(String)
        expect(day[:day][:condition]).to have_key(:icon)
        expect(day[:day][:condition][:icon]).to be_a(String)

        expect(day).to have_key(:astro)
        expect(day[:astro]).to be_a(Hash)
        expect(day[:astro]).to have_key(:sunrise)
        expect(day[:astro][:sunrise]).to be_a(String)
        expect(day[:astro]).to have_key(:sunset)
        expect(day[:astro][:sunset]).to be_a(String)
      end
    end

    it 'returns hourly weather data for next 24 hours', :vcr do
      weather = WeatherService.hourly_weather(39.74001, -104.99202)

      expect(weather).to be_a(Hash)
      weather[:forecast][:forecastday].each do |hour|
        expect(hour[:hour]).to be_a(Array)
        expect(hour[:hour].count).to eq(24)
        expect(hour[:hour][0]).to be_a(Hash)
        expect(hour[:hour][0]).to have_key(:time)
        expect(hour[:hour][0][:time]).to be_a(String)
        expect(hour[:hour][0]).to have_key(:temp_f)
        expect(hour[:hour][0][:temp_f]).to be_a(Float)
        expect(hour[:hour][0]).to have_key(:condition)
        expect(hour[:hour][0][:condition]).to be_a(Hash)
        expect(hour[:hour][0][:condition]).to have_key(:text)
        expect(hour[:hour][0][:condition][:text]).to be_a(String)
        expect(hour[:hour][0][:condition]).to have_key(:icon)
        expect(hour[:hour][0][:condition][:icon]).to be_a(String)
      end
    end
  end
end