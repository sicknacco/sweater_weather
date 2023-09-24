require 'rails_helper'

RSpec.describe RoadTrip do
  describe 'initialize' do
    it 'exists and has attributes' do
      origin = 'Denver, CO'
      destination = 'Pueblo, CO'
    
      road_trip = RoadTrip.new(origin, destination, travel_time, arrival_forecast)

      expect(road_trip).to be_a(RoadTrip)
      expect(road_trip.start_city).to eq(origin)
      expect(road_trip.end_city).to eq(destination)
      expect(road_trip.travel_time).to eq(travel_time)
      expect(road_trip.weather_at_eta).to be_a(Hash)
      expect(road_trip.weather_at_eta[:temperature]).to eq(arrival_forecast[:temperature])
      expect(road_trip.weather_at_eta[:conditions]).to eq(arrival_forecast[:conditions])
    end
  end
end