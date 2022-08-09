require 'rails_helper'

RSpec.describe RoadTrip do
  it 'exists with attributes' do
    weather_at_eta = {
      "temperature": 69.42,
      "conditions": 'sunny'
    }

    road_trip = RoadTrip.new('Kenosha, WI', 'Chicago, IL', '02:00:20', weather_at_eta)

    expect(road_trip).to be_a RoadTrip
    expect(road_trip.id).to eq nil
    expect(road_trip.start_city).to eq 'Kenosha, WI'
    expect(road_trip.end_city).to eq 'Chicago, IL'
    expect(road_trip.travel_time).to eq('02:00:20')
    expect(road_trip.weather_at_eta).to be_a Hash
  end

  it 'return with impossible route and nil weather' do
    weather_at_eta = nil
    travel_time = 'impossible route'

    road_trip = RoadTrip.new('Kenosha, WI', 'London', travel_time, weather_at_eta)

    expect(road_trip).to be_a RoadTrip
    expect(road_trip.id).to eq nil
    expect(road_trip.start_city).to eq 'Kenosha, WI'
    expect(road_trip.end_city).to eq 'London'
    expect(road_trip.travel_time).to eq 'impossible route'
    expect(road_trip.weather_at_eta).to eq nil
  end
end