require 'rails_helper'

RSpec.descripe "POST /session", type: :request do
  it "creates a new session" do
    payload = {
      email: 'bob@bob.com',
      password: 'password'
    }
    headers = {
      "CONTENT_TYPE" => "application/json",
      "ACCEPT" => "application/json"
    }
    post "/api/v0/sessions", headers: headers, params: JSON.generate(payload)

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
    expect(session_data[:data][:attributes]).to have_key(:api_key)
    expect(session_data[:data][:attributes][:api_key]).to be_a(String)
  end
end