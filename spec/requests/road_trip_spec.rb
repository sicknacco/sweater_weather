require 'rails_helper'

RSpec.describe "POST /api/v0/road_trip", type: :request do
  before :each do
    @user = User.create!(email: 'bob@bob.com', password: 'password', password_confirmation: 'password', api_key: '123456789')
  end

  describe "happy path" do
    it 'can get road trip info', :vcr do
      payload = {
        origin: 'new york, ny',
        destination: 'los angeles, ca',
        api_key: @user.api_key
      }
      headers = {
        "CONTENT_TYPE" => "application/json",
        "ACCEPT" => "application/json"
      }
      
      post '/api/v0/road_trip', headers: headers, params: JSON.generate(payload)

      expect(response).to be_successful
      expect(response.status).to eq(201)
      
      trip = JSON.parse(response.body, symbolize_names: true)

      expect(trip).to be_a(Hash)
      expect(trip).to have_key(:data)
      expect(trip[:data]).to be_a(Hash)
      expect(trip[:data]).to have_key(:id)
      expect(trip[:data][:id]).to be(nil)
      expect(trip[:data]).to have_key(:type)
      expect(trip[:data][:type]).to be_a(String)
      expect(trip[:data][:type]).to eq('road_trip')

      expect(trip[:data]).to have_key(:attributes)
      expect(trip[:data][:attributes]).to be_a(Hash)
      expect(trip[:data][:attributes]).to have_key(:start_city)
      expect(trip[:data][:attributes][:start_city]).to be_a(String)
      expect(trip[:data][:attributes]).to have_key(:end_city)
      expect(trip[:data][:attributes][:end_city]).to be_a(String)
      expect(trip[:data][:attributes]).to have_key(:travel_time)
      expect(trip[:data][:attributes][:travel_time]).to be_a(String)

      expect(trip[:data][:attributes]).to have_key(:weather_at_eta)
      expect(trip[:data][:attributes][:weather_at_eta]).to be_a(Hash)
      expect(trip[:data][:attributes][:weather_at_eta]).to have_key(:datetime)
      expect(trip[:data][:attributes][:weather_at_eta][:datetime]).to be_a(String)
      expect(trip[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
      expect(trip[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Float)
      expect(trip[:data][:attributes][:weather_at_eta]).to have_key(:condition)
      expect(trip[:data][:attributes][:weather_at_eta][:condition]).to be_a(String)
    end
  end
end