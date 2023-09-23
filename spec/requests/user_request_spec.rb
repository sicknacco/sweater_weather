require 'rails_helper'

RSpec.describe 'User API' do
  it 'can create a new user' do
    params = {
      email: 'that_one_guy@gmail.com',
      password: 'password',
      password_confirmation: 'password'
    }
    headers = { 'CONTENT_TYPE' => 'application/json' }

    post '/api/v0/users', headers: headers, params: JSON.generate(params)

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
  end
end