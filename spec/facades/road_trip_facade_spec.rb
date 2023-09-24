require 'rails_helper'

RSpec.describe RoadTripFacade do
  describe 'class methods' do
    it 'can get road trip info', :vcr do
      road_trip = RoadTripFacade.get_trip('new york, ny', 'los angeles, ca')

      expect(road_trip).to be_a(RoadTrip)
    end
  end
end