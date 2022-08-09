require 'rails_helper'

RSpec.describe WeatherFacade, :vcr do 
  describe 'all_weather' do
    it 'returns weather object' do
        weather = WeatherFacade.all_weather('39.738453', '-104.984853')
        expect(weather).to be_an_instance_of(Weather)
    end
  end
  describe 'current_weather' do
    it 'returns current weather object' do
        current_weather = WeatherFacade.current_weather('39.738453', '-104.984853')
        expect(current_weather).to be_an_instance_of(CurrentWeather)
    end
  end

  describe 'hourly_weather' do
    it 'returns array of 8 hourly objects' do
        hourly_weather = WeatherFacade.hourly_weather('39.738453', '-104.984853')
        expect(hourly_weather).to be_an(Array)
        expect(hourly_weather.count).to eq(8)
        hourly_weather.each { |hour| expect(hour).to be_an_instance_of(HourlyWeather) }
    end
  end

  describe 'daily_weather' do
    it 'returns array of 5 daily objects' do
        daily_weather = WeatherFacade.daily_weather('39.738453', '-104.984853')
        expect(daily_weather).to be_an(Array)
        expect(daily_weather.count).to eq(5)
        daily_weather.each { |day| expect(day).to be_an_instance_of(DailyWeather) }
    end
  end 

  describe 'weather_at_destination' do
    it 'returns weather at destination' do
        wad = WeatherFacade.weather_at_destination('Dallas, TX', '19:29:34')
        expect(wad).to be_a(DestinationWeather)
        expect(wad.temperature).to be_a(Float)
        expect(wad.conditions).to be_a(String)
    end
  end 
end