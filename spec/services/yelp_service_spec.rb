require 'rails_helper'

RSpec.describe YelpService do
  context '#get_food' do
    it 'returns restaurants' do
      location = 'Kenosha,WI'
      cuisine = 'Italian'
      response = YelpService.get_food(location, cuisine)
      restaurant = response[:businesses]
      
      expect(response).to be_a Hash
      expect(restaurant).to be_an Array
      expect(restaurant.first).to be_a Hash
      expect(restaurant.first).to have_key :name
      expect(restaurant.first).to have_key :location
      expect(restaurant.first[:location]).to have_key :display_address
    end
  end
end