require 'rails_helper'

RSpec.describe "POST /api/v0/sessions", type: :request do
  before :each do
    @user = User.create!(email: 'bob@bob.com', password: 'password', password_confirmation: 'password', api_key: '123456789')
  end

  describe "happy path" do
    it "creates a new session" do
      payload = {
        email: 'bob@bob.com',
        password: 'password'
      }
      headers = {
        "CONTENT_TYPE" => "application/json",
        "ACCEPT" => "application/json"
      }
      post "/api/v0/sessions", headers: headers, params: payload, as: :json
      
      expect(response).to be_successful
      
      session_data = JSON.parse(response.body, symbolize_names: true)
      
      expect(session_data).to be_a(Hash)
      expect(session_data).to have_key(:data)
      expect(session_data[:data]).to be_a(Hash)
      
      expect(session_data[:data]).to have_key(:type)
      expect(session_data[:data][:type]).to be_a(String)
      expect(session_data[:data][:type]).to eq('user')
      
      expect(session_data[:data]).to have_key(:id)
      expect(session_data[:data][:id]).to be_a(String)
      expect(session_data[:data]).to have_key(:attributes)
      
      expect(session_data[:data][:attributes]).to be_a(Hash)
      expect(session_data[:data][:attributes]).to have_key(:email)
      expect(session_data[:data][:attributes][:email]).to be_a(String)
      expect(session_data[:data][:attributes][:email]).to eq(@user.email)
      
      expect(session_data[:data][:attributes]).to have_key(:api_key)
      expect(session_data[:data][:attributes][:api_key]).to be_a(String)
      expect(session_data[:data][:attributes][:api_key]).to eq(@user.api_key)
      expect(session_data[:data][:attributes]).to_not have_key(:password)

      expect(session_data[:data][:attributes].count).to eq(2)  # 2 keys
    end
  end

  describe "sad path" do
    it 'cannot create a new session if password is bad' do
      payload = {
        email: 'bob@bob.com',
        password: 'password1'
      }
      headers = {
        "CONTENT_TYPE" => "application/json",
        "ACCEPT" => "application/json"
      }
      post "/api/v0/sessions", headers: headers, params: payload, as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      error_data = JSON.parse(response.body, symbolize_names: true)

      expect(error_data).to be_a Hash
      expect(error_data).to have_key(:errors)
      expect(error_data[:errors]).to eq('Invalid credentials')
    end
  end
end