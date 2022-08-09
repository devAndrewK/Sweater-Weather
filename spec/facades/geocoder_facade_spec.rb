require 'rails_helper'

RSpec.describe GeocoderFacade, :vcr do
  describe '#get_coordinates' do
    it 'creates geocoder object with lat and lng' do
      location = 'Washington,DC'

      ll = GeocoderFacade.get_coordinates(location)

      expect(ll).to be_a(Geocoder)
      expect(ll.lat).to eq('38.892062')
      expect(ll.lng).to eq('-77.019912')
    end
  end

  describe '#get_travel_time' do
    it 'returns travel time' do
      origin = 'Washington,DC'
      destination = 'Dallas, TX'

      travel_time = GeocoderFacade.get_travel_time(origin, destination)

      expect(travel_time).to be_a(String)
      expect(travel_time).to_not eq("impossible route")
    end

    it 'returns impossible route if route is impossible' do
      origin = 'Washington,DC'
      destination = 'London'

      travel_time = GeocoderFacade.get_travel_time(origin, destination)

      expect(travel_time).to be_a(String)
      expect(travel_time).to eq("impossible route")
    end
  end
end