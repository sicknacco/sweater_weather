require 'rails_helper'

RSpec.describe RoadTripFacade do
  describe 'class methods' do
    it 'can get road trip info', :vcr do
      road_trip = RoadTripFacade.get_trip('new york, ny', 'los angeles, ca')

      expect(road_trip).to be_a(RoadTrip)
      expect(road_trip.start_city).to eq('new york, ny')
      expect(road_trip.end_city).to eq('los angeles, ca')
      expect(road_trip.travel_time).to be_a(String)
      expect(road_trip.weather_at_eta).to be_a(Hash)
      expect(road_trip.weather_at_eta).to have_key(:datetime)
      expect(road_trip.weather_at_eta[:datetime]).to be_a(String)
      expect(road_trip.weather_at_eta).to have_key(:temperature)
      expect(road_trip.weather_at_eta[:temperature]).to be_a(Float)
      expect(road_trip.weather_at_eta).to have_key(:condition)
      expect(road_trip.weather_at_eta[:condition]).to be_a(String)
    end
  end
end