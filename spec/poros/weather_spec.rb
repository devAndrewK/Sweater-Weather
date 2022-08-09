require 'rails_helper'

RSpec.describe Weather, :vcr do
  before :each do
    ll = GeocoderFacade.get_coordinates('Kenosha, WI')
    @weather = Weather.new(WeatherService.get_open_weather(ll.lat, ll.lng))
  end
  it 'exists' do
    expect(@weather).to be_an_instance_of(Weather)
    expect(@weather.id).to eq(nil)
  end

  it 'has current_weather' do
    current = @weather.current_weather
    expect(current).to be_an_instance_of(CurrentWeather)
    expect(current.datetime).to be_a String
    expect(current.sunrise).to be_a String
    expect(current.sunset).to be_a String
    expect(current.temperature).to be_a Float
    expect(current.feels_like).to be_a Float
    expect(current.humidity).to be_a Integer
    expect(current.uvi).to be_a Float
    expect(current.visibility).to be_a Integer
    expect(current.conditions).to be_a String
    expect(current.icon).to be_a String
  end

  it 'has array of daily_weather objects' do
    expect(@weather.daily_weather).to be_an Array
    day = @weather.daily_weather.first
    expect(day).to be_an_instance_of(DailyWeather)
    expect(day.date).to be_a String
    expect(day.sunrise).to be_a String
    expect(day.sunset).to be_a String
    expect(day.max_temp).to be_a Float
    expect(day.min_temp).to be_a Float
    expect(day.conditions).to be_a String
    expect(day.icon).to be_a String
  end

  it 'has array of hourly_weather objects' do
    expect(@weather.hourly_weather).to be_an Array
    hour = @weather.hourly_weather.first
    expect(hour).to be_an_instance_of(HourlyWeather)
    expect(hour.time).to be_a String
    expect(hour.temperature).to be_a Float
    expect(hour.conditions).to be_a String
    expect(hour.icon).to be_a String
  end
end