class WeatherService
  def self.get_open_weather(lat, lng)
    response = BaseService.weather_connection.get('/data/3.0/onecall') do |f|
      f.params['appid'] = ENV['WEATHER_KEY']
      f.params['lat'] = lat
      f.params['lon'] = lng
      f.params['units'] = 'imperial'
      f.params['exclude'] = 'minutely,alerts'
    end
    BaseService.get_json(response)
  end
end