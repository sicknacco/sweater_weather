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

  describe 'directions' do
    it 'returns directions data and weather coordinates for destination', :vcr do
      directions = MapService.get_directions('cedaredge,co', 'eckert,c0')

      expect(directions).to be_a(Hash)
      expect(directions[:route]).to be_a(Hash)

      expect(directions[:route]).to have_key(:formattedTime)
      expect(directions[:route][:formattedTime]).to be_a(String)

      expect(directions[:route]).to have_key(:locations)
      expect(directions[:route][:locations]).to be_a(Array)
      expect(directions[:route][:locations][0]).to be_a(Hash)
      expect(directions[:route][:locations][0]).to have_key(:adminArea5)
      expect(directions[:route][:locations][0][:adminArea5]).to eq('Cedaredge')
      expect(directions[:route][:locations][1][:adminArea5]).to eq('Eckert')

      expect(directions[:route][:locations][1]).to have_key(:latLng)
      expect(directions[:route][:locations][1][:latLng]).to be_a(Hash)
      expect(directions[:route][:locations][1][:latLng]).to have_key(:lat)
      expect(directions[:route][:locations][1][:latLng][:lat]).to be_a(Float)
      expect(directions[:route][:locations][1][:latLng]).to have_key(:lng)
      expect(directions[:route][:locations][1][:latLng][:lng]).to be_a(Float)
    end
  end
end