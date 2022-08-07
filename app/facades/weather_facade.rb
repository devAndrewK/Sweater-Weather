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
end