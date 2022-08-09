require 'rails_helper'

RSpec.describe 'Forecast API' do
  before :each do
    response = JSON.parse(File.read('spec/fixtures/weather.json'), symbolize_names: true)
    stub_request(:get, "https://api.openweathermap.org/data/3.0/onecall?appid=3f1e2bdc5fe6157c146052ce9ab7bf1b&exclude=minutely,alerts&lat=39.738453&lon=-104.984853&units=imperial").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'User-Agent'=>'Faraday v2.4.0'
           }).
         to_return(status: 200, body: JSON.generate(response), headers: {})
    map_response = JSON.parse(File.read('spec/fixtures/mapquest.json'), symbolize_names: true)
    stub_request(:get, "https://www.mapquestapi.com/geocoding/v1/address/?content_type=application/json&key=szwDeVZrYMrGQQCgI7P0jlydYh0hYmJo&location=denver,co").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'User-Agent'=>'Faraday v2.4.0'
           }).
         to_return(status: 200, body: JSON.generate(map_response), headers: {})
  end
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
      expect(current_weather[:datetime]).to eq('2022-08-06 13:40 -0500')
      expect(current_weather[:sunrise]).to eq('2022-08-06 07:03 -0500')
      expect(current_weather[:sunset]).to eq('2022-08-06 21:08 -0500')
      expect(current_weather[:temperature]).to eq(86.81)
      expect(current_weather[:feels_like]).to eq(86.18)
      expect(current_weather[:humidity]).to eq(39)
      expect(current_weather[:uvi]).to eq(9.31)
      expect(current_weather[:visibility]).to eq(10000)
      expect(current_weather[:conditions]).to eq('clear sky')
      expect(current_weather[:icon]).to eq('01d')

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
