require 'rails_helper'

RSpec.describe Geocoder do
  it 'exists and has attributes' do
    lat = '42.5293'
    lng = '-87.8855'

    ll = Geocoder.new(lat, lng)

    expect(ll).to be_a(Geocoder)
    expect(ll.lat).to eq('42.5293')
    expect(ll.lng).to eq('-87.8855')
  end
end