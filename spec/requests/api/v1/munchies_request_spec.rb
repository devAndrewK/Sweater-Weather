require 'rails_helper'

RSpec.describe 'Munchies API' do
  it 'returns json with forecast and restaurant recommendation' do
    get "/api/v1/munchies?location=kenosha,wi&food=italian"

    expect(response).to be_successful
    response_body = JSON.parse(response.body, symbolize_names: true)

    munchies = response_body[:data]
  end
    
end