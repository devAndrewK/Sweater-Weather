class Weather
  attr_reader :id,
              :current_weather, 
              :daily_weather,
              :hourly_weather

  def initialize(data)
    @id = nil
    @current_weather = CurrentWeather.new(data[:current])
    @hourly_weather = data[:hourly].first(8).map { |hour| HourlyWeather.new(hour) }
    @daily_weather = data[:daily].first(5).map { |day| DailyWeather.new(day) }
  end
end