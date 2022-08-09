require 'rails_helper'

RSpec.describe DailyWeather, :vcr do
  it 'exists with attributes' do
    ll = GeocoderFacade.get_coordinates('Kenosha, WI')
    parsed_json = WeatherService.get_open_weather(ll.lat, ll.lng)

    daily = DailyWeather.new(parsed_json[:daily].first)

    expect(daily).to be_a DailyWeather
    expect(daily.date).to be_a String
    expect(daily.sunrise).to be_a String
    expect(daily.sunset).to be_a String
    expect(daily.max_temp).to be_a Float
    expect(daily.min_temp).to be_a Float
    expect(daily.conditions).to be_a String
    expect(daily.icon).to be_a String
  end
end