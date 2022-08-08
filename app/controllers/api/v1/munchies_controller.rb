class MunchiesController < ApplicationController
  def show 
    ll = GeocoderFacade.get_coordinates(params[:location])
    weather = WeatherFacade.current_weather(ll.lat, ll.lng)
    food = YelpFacade.get_food(params[:location], params[:food])

    render json: MunchieSerializer.new(weather, food)
  end
end