class BaseService
  def self.get_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.geocoder_connection
    Faraday.new(url: 'https://www.mapquestapi.com')
  end

  def self.weather_connection
    Faraday.new(url: 'https://api.openweathermap.org')
  end
end