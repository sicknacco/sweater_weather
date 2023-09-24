require 'rails_helper'

RSpec.describe RoadTripFacade do
  describe 'happy path' do
    it 'can get road trip info', :vcr do
      road_trip = RoadTripFacade.get_trip('new york, ny', 'los angeles, ca')

      expect(road_trip).to be_a(RoadTrip)
      expect(road_trip.id).to eq(nil)
      expect(road_trip.type).to eq('roadtrip')
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

  describe 'sad path' do
    it 'returns impossible route and empty hash', :vcr do
      impossible = RoadTripFacade.get_trip('new york, ny', 'london, uk')

      expect(impossible).to be_a(RoadTrip)
      expect(impossible.id).to eq(nil)
      expect(impossible.type).to eq('roadtrip')
      expect(impossible.start_city).to eq('new york, ny')
      expect(impossible.end_city).to eq('london, uk')
      expect(impossible.travel_time).to eq('impossible route')
      expect(impossible.weather_at_eta).to eq({})
    end
  end
end