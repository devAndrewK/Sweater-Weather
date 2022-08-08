class Api::V1::MunchiesController < ApplicationController
  def show 
    if params[:location].blank? || params[:food].blank?
      render status: 400
    else
      ll = GeocoderFacade.get_coordinates(params[:location])
      weather = WeatherFacade.current_weather(ll.lat, ll.lng)
      food = YelpFacade.get_food(params[:location], params[:food])

      render json: MunchieSerializer.munchies(weather, food)
    end
  end
end