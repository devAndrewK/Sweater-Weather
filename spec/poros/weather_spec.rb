require 'rails_helper'

RSpec.describe Weather do
  before :each do
    weather_response = JSON.parse(File.read('spec/fixtures/weather.json'), symbolize_names: true)
    @weather = Weather.new(weather_response)
  end
  it 'exists' do
    expect(@weather).to be_an_instance_of(Weather)
    expect(@weather.id).to eq(nil)
  end

  it 'has current_weather' do
    current = @weather.current_weather
    expect(current).to be_an_instance_of(CurrentWeather)
    expect(current.datetime).to eq("2022-08-06 13:40 -0500")
    expect(current.sunrise).to eq("2022-08-06 07:03 -0500")
    expect(current.sunset).to eq("2022-08-06 21:08 -0500")
    expect(current.temperature).to eq(86.81)
    expect(current.feels_like).to eq(86.18)
    expect(current.humidity).to eq(39)
    expect(current.uvi).to eq(9.31)
    expect(current.visibility).to eq(10000)
    expect(current.conditions).to eq("clear sky")
    expect(current.icon).to eq("01d")
  end

  it 'has array of daily_weather objects' do
    expect(@weather.daily_weather).to be_an Array
    day = @weather.daily_weather.first
    expect(day).to be_an_instance_of(DailyWeather)
    expect(day.date).to eq("08-06-2022")
    expect(day.sunrise).to eq("2022-08-06 14:00 -0500")
    expect(day.sunset).to eq("2022-08-06 14:00 -0500")
    expect(day.max_temp).to eq(89.19)
    expect(day.min_temp).to eq(72.77)
    expect(day.conditions).to eq("light rain")
    expect(day.icon).to eq("10d")
  end

  it 'has array of hourly_weather objects' do
    expect(@weather.hourly_weather).to be_an Array
    hour = @weather.hourly_weather.first
    expect(hour).to be_an_instance_of(HourlyWeather)
    expect(hour.time).to eq("13:00 -0500")
    expect(hour.temperature).to eq(86.61)
    expect(hour.conditions).to eq("few clouds")
    expect(hour.icon).to eq("02d")
  end
end