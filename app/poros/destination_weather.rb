class DestinationWeather
  attr_reader :temperature,
              :conditions

  def initialize(travel_hours, weather_data)
    @temperature = ''
    @conditions = ''
    set_weather(travel_hours, weather_data)
  end

  def set_weather(travel_hours, weather_data)
    if travel_hours > 24
      @temperature = weather_data[:daily][(travel_hours / 24).to_i][:temp][:day]
      @conditions = weather_data[:daily][(travel_hours / 24).to_i][:weather].first[:description]
    else
      @temperature = weather_data[:hourly][(travel_hours).to_i][:temp]
      @conditions = weather_data[:hourly][(travel_hours).to_i][:weather].first[:description]
    end
  end

end