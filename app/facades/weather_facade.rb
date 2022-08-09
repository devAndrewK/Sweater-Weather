class WeatherFacade

  def self.daily_weather(lat, lng)
    WeatherService.get_open_weather(lat, lng)[:daily].first(5).map { |data| DailyWeather.new(data) }
  end

  def self.hourly_weather(lat, lng)
    WeatherService.get_open_weather(lat, lng)[:hourly].first(8).map { |data| HourlyWeather.new(data) }
  end

  def self.current_weather(lat, lng)
    CurrentWeather.new(WeatherService.get_open_weather(lat, lng)[:current])
  end

  def self.all_weather(lat, lng)
    Weather.new(WeatherService.get_open_weather(lat, lng))
  end

  def self.weather_at_destination(destination, travel_time)
    if travel_time == 'impossible route'
      nil
    else
      ll = GeocoderFacade.get_coordinates(destination)
      weather_data = WeatherService.get_open_weather(ll.lat, ll.lng)
      DestinationWeather.new(travel_time.split(':').first.to_i, weather_data)
    end
  end
end