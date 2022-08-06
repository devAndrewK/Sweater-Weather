require 'rails_helper'

RSpec.describe 'Forecast API' do
    it 'returns forecasted weather for a location' do
      headers = { 'CONTENT_TYPE' => 'application/json' }
      get '/api/v1/forecast', headers: headers, params: { location: 'denver,co' }
      

      expect(response).to be_successful
      rb = JSON.parse(response.body, symbolize_names: true)
      forecast = rb[:data]

      expect(forecast).to be_an Array
    end
end
