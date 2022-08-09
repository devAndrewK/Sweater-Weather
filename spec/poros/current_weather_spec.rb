require 'rails_helper'

RSpec.describe CurrentWeather, :vcr do
  it 'exists with attributes' do
    ll = GeocoderFacade.get_coordinates('Kenosha, WI')
    parsed_json = WeatherService.get_open_weather(ll.lat, ll.lng)

    current = CurrentWeather.new(parsed_json[:current])

    expect(current).to be_a CurrentWeather
    expect(current.datetime).to be_a String
    expect(current.sunrise).to be_a String
    expect(current.sunset).to be_a String
    expect(current.temperature).to be_a Float
    expect(current.feels_like).to be_a Float
    expect(current.humidity).to be_a Integer
    expect(current.uvi).to_not be_a String
    expect(current.visibility).to be_a Integer
    expect(current.conditions).to be_a String
    expect(current.icon).to be_a String
  end
end