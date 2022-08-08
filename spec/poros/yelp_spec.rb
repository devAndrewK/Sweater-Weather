require 'rails_helper'

RSpec.describe Yelp do
  it 'exists and has attributes' do
    name = "Renzo's Pizzeria and Trattoria"
    location = ["2820 52nd St",
                    "Kenosha, WI 53140"]

    yelp = Yelp.new(name, location)

    expect(yelp).to be_a(Yelp)
    expect(yelp.name).to eq("Renzo's Pizzeria and Trattoria")
    expect(yelp.address).to eq("2820 52nd St Kenosha, WI 53140")
  end
end