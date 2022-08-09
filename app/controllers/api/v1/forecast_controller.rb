class Api::V1::ForecastController < ApplicationController
  def show
    ll = GeocoderFacade.get_coordinates(params[:location])
    weather = WeatherFacade.all_weather(ll.lat, ll.lng)
    render json: WeatherSerializer.new(weather)
  end
end