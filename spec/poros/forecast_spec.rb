require 'rails_helper'

RSpec.describe Forecast do
  before(:each) do
    @location = 'San Diego, CA'
    @weather = ForecastFacade.get_forecast(@location)
  end

  it 'exists and has attributes', :vcr do
    expect(@weather).to be_a(Forecast)
    expect(@weather.id).to eq(nil)
    expect(@weather.type).to eq('forecast')
    expect(@weather.type).to be_a(String)
    expect(@weather.current_weather).to be_a(Hash)
    expect(@weather.daily_weather).to be_a(Array)
    expect(@weather.hourly_weather).to be_a(Array)
  end

  it 'has current weather attributes', :vcr do
    expect(@weather.current_weather).to have_key(:last_updated)
    expect(@weather.current_weather[:last_updated]).to be_a(String)
    expect(@weather.current_weather).to have_key(:temperature)
    expect(@weather.current_weather[:temperature]).to be_a(Float)
    expect(@weather.current_weather).to have_key(:feels_like)
    expect(@weather.current_weather[:feels_like]).to be_a(Float)
    expect(@weather.current_weather).to have_key(:humidity)
    expect(@weather.current_weather[:humidity]).to be_a(Float).or be_an(Integer)
    expect(@weather.current_weather).to have_key(:uvi)
    expect(@weather.current_weather[:uvi]).to be_a(Float)
    expect(@weather.current_weather).to have_key(:visibility)
    expect(@weather.current_weather[:visibility]).to be_a(Float)
    expect(@weather.current_weather).to have_key(:condition)
    expect(@weather.current_weather[:condition]).to be_a(String)
    expect(@weather.current_weather).to have_key(:icon)
  end
end