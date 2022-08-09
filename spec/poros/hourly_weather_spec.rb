require 'rails_helper'

RSpec.describe HourlyWeather, :vcr do
  it 'exists with attributes' do
    ll = GeocoderFacade.get_coordinates('Kenosha, WI')
    parsed_json = WeatherService.get_open_weather(ll.lat, ll.lng)

    hourly = HourlyWeather.new(parsed_json[:hourly].first)

    expect(hourly).to be_a HourlyWeather
    expect(hourly.time).to be_a String
    expect(hourly.temperature).to be_a Float
    expect(hourly.conditions).to be_a String
    expect(hourly.icon).to be_a String
  end
end