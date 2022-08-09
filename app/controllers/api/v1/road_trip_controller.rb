class Api::V1::RoadTripController < ApplicationController
  def create
    api_user = User.find_by(api_key: params[:api_key])
    if api_user.present?
      travel_time = GeocoderFacade.get_travel_time(params[:origin], params[:destination])
      weather = WeatherFacade.weather_at_destination(params[:destination], travel_time)
      road_trip = RoadTrip.new(params[:origin], params[:destination], travel_time, weather)
      render json: RoadTripSerializer.new(road_trip)
    else
      render json: { error: 'Credentials Invalid Or Blank' }, status: :unauthorized
    end
  end
end