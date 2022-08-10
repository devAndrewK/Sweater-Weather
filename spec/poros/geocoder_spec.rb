require 'rails_helper'

RSpec.describe Geocoder, :vcr do
  it 'exists and has attributes' do
    location = GeocoderService.get_coordinates("Kenosha, WI")
    ll = Geocoder.new(location)

    expect(ll).to be_a(Geocoder)
    expect(ll.lat).to eq('42.588079')
    expect(ll.lng).to eq('-87.822877')
  end
end