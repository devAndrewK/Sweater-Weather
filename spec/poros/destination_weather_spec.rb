require 'rails_helper'

RSpec.describe DestinationWeather do
  it 'exists with attributes when time is under 24 hours' do
    weather = JSON.parse(File.read('spec/fixtures/weather.json'), symbolize_names: true)

    destination_weather = DestinationWeather.new(4, weather)

    expect(destination_weather).to be_a DestinationWeather
    expect(destination_weather.temperature).to be_a Float
    expect(destination_weather.conditions).to be_a String
  end

    it 'exists with attributes when time over 24 hours' do
    weather = JSON.parse(File.read('spec/fixtures/weather.json'), symbolize_names: true)

    destination_weather = DestinationWeather.new(50, weather)

    expect(destination_weather).to be_a DestinationWeather
    expect(destination_weather.temperature).to be_a Float
    expect(destination_weather.conditions).to be_a String
  end
end