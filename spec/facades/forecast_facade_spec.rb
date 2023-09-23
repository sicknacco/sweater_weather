require 'rails_helper'

RSpec.describe 'Forecast facade' do
  it 'returns a forecast object for a city', :vcr do
    location = 'San Diego, CA'
    weather = ForecastFacade.get_forecast(location)

    expect(weather).to be_a(Forecast)
    expect(weather.id).to eq(nil)
    expect(weather.type).to eq('forecast')
    expect(weather.type).to be_a(String)
    expect(weather.current_weather).to be_a(Hash)
    expect(weather.daily_weather).to be_a(Array)
    expect(weather.hourly_weather).to be_a(Array)
  end
end