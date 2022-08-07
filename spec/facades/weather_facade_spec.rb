require 'rails_helper'

RSpec.describe WeatherFacade do 
  before :each do
    response = JSON.parse(File.read('spec/fixtures/weather.json'), symbolize_names: true)
    stub_request(:get, "https://api.openweathermap.org/data/3.0/onecall?appid=3f1e2bdc5fe6157c146052ce9ab7bf1b&exclude=minutely,alerts&lat=39.738453&lon=-104.984853&units=imperial").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'User-Agent'=>'Faraday v2.4.0'
           }).
         to_return(status: 200, body: JSON.generate(response), headers: {})
  end

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
end