require 'rails_helper'

RSpec.describe RoadTrip do
  describe 'initialize' do
    it 'exists and has attributes' do
      origin = 'cedaredge, co'
      destination = 'eckert, co'
      travel_time = '00:15:00'
      arrival_forecast = {
        datetime: Time.now + 3600,
        temperature: 50.0,
        condition: 'sunny'
      }
    
      road_trip = RoadTrip.new(origin, destination, travel_time, arrival_forecast)

      expect(road_trip).to be_a(RoadTrip)
      expect(road_trip.id).to eq(nil)
      expect(road_trip.type).to eq('roadtrip')
      expect(road_trip.start_city).to eq(origin)
      expect(road_trip.end_city).to eq(destination)
      expect(road_trip.travel_time).to eq(travel_time)
      expect(road_trip.weather_at_eta).to eq(arrival_forecast)

      expect(road_trip.weather_at_eta).to have_key(:datetime)
      expect(road_trip.weather_at_eta[:datetime]).to be_a(Time)
      expect(road_trip.weather_at_eta).to have_key(:temperature)
      expect(road_trip.weather_at_eta[:temperature]).to be_a(Float)
      expect(road_trip.weather_at_eta).to have_key(:condition)
      expect(road_trip.weather_at_eta[:condition]).to be_a(String)
    end
  end
end