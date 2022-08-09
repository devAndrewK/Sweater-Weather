require 'rails_helper'

RSpec.describe 'RoadTrip api', :vcr do
  context 'happy path' do
    it 'returns roadtrip object when given valid api key and destination' do
      body = {
        "email": "whatever@example.com",
        "password": "password",
        "password_confirmation": "password"
      }
      post '/api/v1/users', params: body

      parsed_user_body = JSON.parse(response.body, symbolize_names: true)
      api_key = parsed_user_body[:data][:attributes][:api_key]

      api_data = {
        "origin": 'Kenosha, WI',
        "destination": 'Denver, CO',
        "api_key": api_key
      }

      post '/api/v1/road_trip', params: api_data

      expect(response).to be_successful

      parsed_body = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_body).to have_key(:data)
      expect(parsed_body[:data]).to be_a Hash

      road_trip = parsed_body[:data]

      expect(road_trip).to have_key :id
      expect(road_trip).to have_key :type
      expect(road_trip[:type]).to eq('road_trip')

      expect(road_trip).to have_key :attributes

      expect(road_trip[:attributes]).to have_key :start_city
      expect(road_trip[:attributes][:start_city]).to be_a String

      expect(road_trip[:attributes]).to have_key :end_city
      expect(road_trip[:attributes][:end_city]).to be_a String

      expect(road_trip[:attributes]).to have_key :travel_time
      expect(road_trip[:attributes][:travel_time]).to be_a String

      expect(road_trip[:attributes]).to have_key :weather_at_eta
      expect(road_trip[:attributes][:weather_at_eta]).to be_a Hash

      expect(road_trip[:attributes][:weather_at_eta]).to have_key :temperature
      expect(road_trip[:attributes][:weather_at_eta]).to have_key :conditions
      expect(road_trip[:attributes][:weather_at_eta][:temperature]).to be_a Float
      expect(road_trip[:attributes][:weather_at_eta][:conditions]).to be_a String
    end
  end

  context 'sad path' do
    it 'api key invalid' do
      body = {
        "email": "whatever@example.com",
        "password": "password",
        "password_confirmation": "password"
      }
      post '/api/v1/users', params: body

      parsed_user_body = JSON.parse(response.body, symbolize_names: true)
      api_key = parsed_user_body[:data][:attributes][:api_key]

      api_data = {
        "origin": 'Kenosha, WI',
        "destination": 'Denver, CO',
        "api_key": '1234455424324'
      }

      post '/api/v1/road_trip', params: api_data

      expect(response).to_not be_successful

      parsed_body = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_body[:error]).to eq('Credentials Invalid Or Blank')
    end

    it 'returns impossible route and blank weather' do
      body = {
        "email": "whatever@example.com",
        "password": "password",
        "password_confirmation": "password"
      }
      post '/api/v1/users', params: body

      parsed_user_body = JSON.parse(response.body, symbolize_names: true)
      api_key = parsed_user_body[:data][:attributes][:api_key]

      api_data = {
        "origin": 'Kenosha, WI',
        "destination": 'Honolulu, HI',
        "api_key": api_key
      }

      post '/api/v1/road_trip', params: api_data

      expect(response).to be_successful

      parsed_body = JSON.parse(response.body, symbolize_names: true)

      road_trip = parsed_body[:data]

      expect(road_trip[:attributes]).to have_key :travel_time
      expect(road_trip[:attributes][:travel_time]).to eq('impossible route')

      expect(road_trip[:attributes]).to have_key :weather_at_eta
      expect(road_trip[:attributes][:weather_at_eta]).to eq(nil)
    end
  end
end