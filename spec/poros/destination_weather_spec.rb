require 'rails_helper'

RSpec.describe DestinationWeather, :vcr do
  before :each do
    @ll = GeocoderFacade.get_coordinates('Kenosha, WI')
    @weather = WeatherService.get_open_weather(@ll.lat, @ll.lng)
  end

  it 'exists with attributes when time is under 24 hours' do
    destination_weather = DestinationWeather.new(4, @weather)

    expect(destination_weather).to be_a DestinationWeather
    expect(destination_weather.temperature).to be_a Float
    expect(destination_weather.conditions).to be_a String
  end

  it 'exists with attributes when time over 24 hours' do
    destination_weather = DestinationWeather.new(50, @weather)

    expect(destination_weather).to be_a DestinationWeather
    expect(destination_weather.temperature).to be_a Float
    expect(destination_weather.conditions).to be_a String
  end
end