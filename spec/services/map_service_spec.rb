require 'rails_helper'

RSpec.describe MapService do
  describe 'geo_coordinates' do
    it 'returns lat and long for a given city', :vcr do
      location = MapService.city_coordinates('denver,co')

      expect(location).to be_a(Hash)
    
      expect(location[:results][0][:locations][0][:latLng]).to be_a(Hash)
      expect(location[:results][0][:locations][0][:latLng]).to have_key(:lat)
      expect(location[:results][0][:locations][0][:latLng][:lat]).to be_a(Float)
      expect(location[:results][0][:locations][0][:latLng]).to have_key(:lng)
      expect(location[:results][0][:locations][0][:latLng][:lng]).to be_a(Float)
    end
  end
end