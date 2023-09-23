require 'rails_helper'

RSpec.describe 'Forecast facade' do
  it 'returns a forecast object for a city', :vcr do
    location = 'San Diego, CA'
    weather = ForecastFacade.get_forecast(location)

    expect(weather).to be_a(Forecast)
  end
end