require 'rails_helper'

RSpec.describe MapService do
  describe 'geo_coordinates' do
    it 'returns lat and long for a given city' do
      location = MapService.city_coordinates('denver,co')

      expect(location).to be_a(Hash)
    end
  end
end