require 'rails_helper'

RSpec.describe YelpService do
  context '#get_food' do
    it 'returns restaurants' do
      location = 'Washington,DC'
      response = YelpService.get_food(location, cuisine)
      
      expect(response).to be_an Array
      expect(response.first).to be_a Hash
      expect(response.first).to have_key(:name)
      expect(response.first).to have_key(:location)
      expect(response.first[:location]).to have_key(:display_address)
    end
  end
end