require 'rails_helper'

RSpec.describe YelpFacade do
  describe '#get_food' do
    it 'creates yelp object' do
      location = 'Kenosha,WI'
      cuisine = 'Italian'

      yelp = YelpFacade.get_food(location, cuisine)

      expect(yelp).to be_a(Yelp)
      expect(yelp.name).to eq("Renzo's Pizzeria and Trattoria")
      expect(yelp.address).to eq("2820 52nd St Kenosha, WI 53140")
    end
  end
end