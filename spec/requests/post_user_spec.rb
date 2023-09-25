require 'rails_helper'

RSpec.describe 'User API' do
  describe 'happy path' do
    it 'can create a new user' do
      params = {
        email: 'that_one_guy@gmail.com',
        password: 'password',
        password_confirmation: 'password'
      }
      headers = {
        "CONTENT_TYPE" => "application/json",
        "ACCEPT" => "application/json"
      }
      
      post '/api/v0/users', headers: headers, params: params, as: :json
      
      expect(response).to be_successful
      expect(response.status).to eq(201)
      
      user = JSON.parse(response.body, symbolize_names: true)
      
      expect(user).to be_a(Hash)
      expect(user).to have_key(:data)
      expect(user[:data]).to be_a(Hash)
      expect(user[:data]).to have_key(:type)
      expect(user[:data][:type]).to be_a(String)
      expect(user[:data][:type]).to eq('user')
      expect(user[:data]).to have_key(:id)
      expect(user[:data][:id]).to be_a(String)
      expect(user[:data]).to have_key(:attributes)
      
      expect(user[:data][:attributes]).to be_a(Hash)
      expect(user[:data][:attributes]).to have_key(:email)
      expect(user[:data][:attributes][:email]).to be_a(String)
      expect(user[:data][:attributes]).to have_key(:api_key)
      expect(user[:data][:attributes][:api_key]).to be_a(String)

      expect(user[:data][:attributes].count).to eq(2)  # 2 keys
    end
  end
  
  describe 'sad path' do
    it 'cannot create a new user if email is already taken' do
      User.create!(
                  email: 'bob@bob.com',
                  password: 'password',
                  password_confirmation: 'password',
                  api_key: '12345')
      payload = {
        email: 'bob@bob.com',
        password: 'password',
        password_confirmation: 'password'
      }
      headers = {
        "CONTENT_TYPE" => "application/json",
        "ACCEPT" => "application/json"
      }

      post "/api/v0/users", headers: headers, params: payload, as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      error_data = JSON.parse(response.body, symbolize_names: true)

      expect(error_data).to be_a Hash
      expect(error_data).to have_key(:errors)
      expect(error_data[:errors]).to eq('Email has already been taken')
    end

    it 'cannot create a new user if passwords do not match' do
      payload = {
        email: 'tim@tim.com',
        password: 'password',
        password_confirmation: 'password1'
      }
      headers = {
        "CONTENT_TYPE" => "application/json",
        "ACCEPT" => "application/json"
      }

      post "/api/v0/users", headers: headers, params: payload, as: :json

      expect(response).to_not be_successful

      expect(response.status).to eq(400)

      error_data = JSON.parse(response.body, symbolize_names: true)
      
      expect(error_data).to be_a Hash
      expect(error_data).to have_key(:errors)
      expect(error_data[:errors]).to eq("Password confirmation doesn't match Password")
    end

    it 'cannot create a new user without an email' do
      payload = {
        email: '',
        password: 'password',
        password_confirmation: 'password'
      }
      headers = {
        "CONTENT_TYPE" => "application/json",
        "ACCEPT" => "application/json"
      }
      post "/api/v0/users", headers: headers, params: payload, as: :json

      expect(response).to_not be_successful

      expect(response.status).to eq(400)

      error_data = JSON.parse(response.body, symbolize_names: true)
      
      expect(error_data).to be_a Hash
      expect(error_data).to have_key(:errors)
      expect(error_data[:errors]).to eq("Email can't be blank")
    end
  end
end