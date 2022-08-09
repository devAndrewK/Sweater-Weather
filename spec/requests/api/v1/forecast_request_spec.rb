require 'rails_helper'

RSpec.describe 'Forecast API', :vcr do
    it 'returns forecasted weather for a location' do
      headers = { 'CONTENT_TYPE' => 'application/json' }
      get '/api/v1/forecast', headers: headers, params: { location: 'denver,co' }
      
      expect(response).to be_successful
      rb = JSON.parse(response.body, symbolize_names: true)
      forecast = rb[:data]

      expect(forecast).to be_a Hash
      expect(forecast[:id]).to eq(nil)
      expect(forecast[:type]).to eq('forecast')
      current_weather = forecast[:attributes][:current_weather]
      expect(current_weather[:datetime]).to be_a String
      expect(current_weather[:sunrise]).to be_a String
      expect(current_weather[:sunset]).to be_a String
      expect(current_weather[:temperature]).to be_a Float
      expect(current_weather[:feels_like]).to be_a Float
      expect(current_weather[:humidity]).to be_a Integer
      expect(current_weather[:uvi]).to be_a Float
      expect(current_weather[:visibility]).to be_a Integer
      expect(current_weather[:conditions]).to be_a String
      expect(current_weather[:icon]).to be_a String

      expect(current_weather).to_not have_key(:pressure)
      expect(current_weather).to_not have_key(:clouds)
      expect(current_weather).to_not have_key(:dew_point)
      expect(current_weather).to_not have_key(:wind_deg)
      expect(current_weather).to_not have_key(:wind_speed)

      expect(forecast[:attributes][:daily_weather].count).to eq(5)

      day = forecast[:attributes][:daily_weather].first

      expect(day).to be_a(Hash)
      expect(day).to have_key(:date)
      expect(day[:date]).to be_a(String)

      expect(day).to have_key(:sunrise)
      expect(day[:sunrise]).to be_a(String)

      expect(day).to have_key(:sunset)
      expect(day[:sunset]).to be_a(String)

      expect(day).to have_key(:max_temp)
      expect(day[:max_temp]).to be_a(Float)

      expect(day).to have_key(:min_temp)
      expect(day[:min_temp]).to be_a(Float)

      expect(day).to have_key(:conditions)
      expect(day[:conditions]).to be_a(String)

      expect(day).to have_key(:icon)
      expect(day[:icon]).to be_a(String)

      expect(day).to_not have_key(:pressure)
      expect(day).to_not have_key(:dew_point)
      expect(day).to_not have_key(:wind_speed)
      expect(day).to_not have_key(:wind_deg)
      expect(day).to_not have_key(:moonrise)
      expect(day).to_not have_key(:moonset)
      expect(day).to_not have_key(:moon_phase)

      expect(forecast[:attributes]).to have_key(:hourly_weather)
      expect(forecast[:attributes][:hourly_weather].count).to eq(8)

      hour = forecast[:attributes][:hourly_weather].first

      expect(hour).to be_a(Hash)
      expect(hour).to have_key(:time)
      expect(hour[:time]).to be_a(String)

      expect(hour).to have_key(:temperature)
      expect(hour[:temperature]).to be_a(Float)

      expect(hour).to have_key(:conditions)
      expect(hour[:conditions]).to be_a(String)

      expect(hour).to have_key(:icon)
      expect(hour[:icon]).to be_a(String)

      expect(hour).to_not have_key(:pressure)
      expect(hour).to_not have_key(:dew_point)
      expect(hour).to_not have_key(:clouds)
      expect(hour).to_not have_key(:wind_speed)
      expect(hour).to_not have_key(:wind_deg)
      expect(hour).to_not have_key(:wind_gust)
    end
end
