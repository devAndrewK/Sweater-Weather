require 'rails_helper'

RSpec.describe 'Munchies API' do
  it 'returns json with forecast and restaurant recommendation' do
    get "/api/v1/munchies?location=kenosha,wi&food=italian"

    expect(response).to be_successful
    response_body = JSON.parse(response.body, symbolize_names: true)

    munchies = response_body[:data]
    expect(munchies).to have_key(:id)
    expect(munchies[:id]).to be_a String

    expect(munchies).to have_key(:type)
    expect(munchies[:type]).to be_a String

    expect(munchies).to have_key(:attributes)
    expect(munchies[:attributes]).to be_a Hash

    expect(munchies[:attributes]).to have_key(:destination_city)
    expect(munchies[:attributes][:destination_city]).to be_a String

    expect(munchies[:attributes]).to have_key(:forecast)
    expect(munchies[:attributes][:forecast]).to be_a Hash

    expect(munchies[:attributes][:forecast]).to have_key(:summary)
    expect(munchies[:attributes][:forecast][:summary]).to be_a String
    
    expect(munchies[:attributes][:forecast]).to have_key(:temperature)
    expect(munchies[:attributes][:forecast][:temperature]).to be_a Float

    expect(munchies[:attributes]).to have_key(:restaurant)
    expect(munchies[:attributes][:restaurant]).to be_a Hash
    
    expect(munchies[:attributes][:restaurant]).to have_key(:name)
    expect(munchies[:attributes][:restaurant][:name]).to be_a String
    expect(munchies[:attributes][:restaurant]).to have_key(:address)
    expect(munchies[:attributes][:restaurant][:address]).to be_a String
    
    expect(munchies[:attributes][:restaurant]).to_not have_key(:phone)
    expect(munchies[:attributes][:restaurant]).to_not have_key(:review_count)
    expect(munchies[:attributes][:restaurant]).to_not have_key(:rating)
  end

  it 'returns unsuccessful request if location is missing' do
    get "/api/v1/munchies?food=italian"

    expect(response).to_not be_successful
  end

    it 'returns unsuccessful request if cuisine is missing' do
    get "/api/v1/munchies?location=kenosha,wi"

    expect(response).to_not be_successful
  end
    
end