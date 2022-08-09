require 'rails_helper'

RSpec.describe WeatherService, :vcr do 
  it 'returns the weather based on lat long' do 

    response = WeatherService.get_open_weather('39.738453', '-104.984853')

    expect(response).to be_a(Hash)
    expect(response).to have_key(:current)
    expect(response[:current]).to have_key(:dt)
    expect(response[:current]).to have_key(:sunrise)
    expect(response[:current]).to have_key(:sunset)
    expect(response[:current]).to have_key(:temp)
    expect(response[:current]).to have_key(:feels_like)
    expect(response[:current]).to have_key(:humidity)
    expect(response[:current]).to have_key(:uvi)
    expect(response[:current]).to have_key(:visibility)
    expect(response[:current]).to have_key(:weather)
    expect(response[:current]).to have_key(:dt)
    expect(response[:current][:weather].first).to be_a(Hash)
    expect(response[:current][:weather].first).to have_key(:description)
    expect(response[:current][:weather].first).to have_key(:icon)

    expect(response).to have_key(:daily)
    day = response[:daily].first
    expect(day).to have_key(:dt)
    expect(day).to have_key(:sunrise)
    expect(day).to have_key(:sunset)
    expect(day).to have_key(:temp)
    expect(day[:temp]).to have_key(:max)
    expect(day[:temp]).to have_key(:min)
    expect(day).to have_key(:weather)
    expect(day[:weather].first).to be_a(Hash)
    expect(day[:weather].first).to have_key(:description)
    expect(day[:weather].first).to have_key(:icon)

    expect(response).to have_key(:hourly)
    hour = response[:hourly].first
    expect(hour).to have_key(:dt)
    expect(hour).to have_key(:temp)
    expect(hour).to have_key(:weather)
    expect(hour[:weather].first).to be_a(Hash)
    expect(hour[:weather].first).to have_key(:description)
    expect(hour[:weather].first).to have_key(:icon)
  end
end