require 'rails_helper'

RSpec.describe 'Users API' do
  it 'creates a user' do
    headers = { 'CONTENT_TYPE' => 'application/json' }
    body = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }

    post '/api/v1/users', params: body

    expect(response).to be_successful

    parsed_body = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_body).to have_key(:data)
    expect(parsed_body[:data]).to be_a Hash

    user = parsed_body[:data]

    expect(user).to have_key :id
    expect(user[:id]).to be_a String
    expect(user).to have_key :type
    expect(user[:type]).to eq('user')

    expect(user).to have_key :attributes

    expect(user[:attributes]).to have_key :email
    expect(user[:attributes][:email]).to be_a String

    expect(user[:attributes]).to have_key :api_key
    expect(user[:attributes][:api_key]).to be_a String

    expect(user).to_not have_key :created_at
    expect(user).to_not have_key :updated_at
  end
end
