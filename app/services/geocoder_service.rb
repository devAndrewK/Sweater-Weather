class GeocoderService
  def self.get_coordinates(location)
    response = BaseService.geocoder_connection
    .get("/geocoding/v1/address/?key=#{ENV['MAPQUEST_KEY']}&location=#{location}", content_type: 'application/json')
    BaseService.get_json(response)
  end

  def self.get_travel_time(origin, destination)
    response = BaseService.geocoder_connection
    .get("/directions/v2/route?key=#{ENV['MAPQUEST_KEY']}&from=#{origin}&to=#{destination}", content_type: 'application/json')
    BaseService.get_json(response)
  end
end