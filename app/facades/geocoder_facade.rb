class GeocoderFacade
  def self.get_coordinates(location)
    json = GeocoderService.get_coordinates(location)
    lat = json[:results].first[:locations].first[:latLng][:lat].to_s
    lng = json[:results].first[:locations].first[:latLng][:lng].to_s
    Geocoder.new(lat, lng)
  end

  def self.get_travel_time(origin, destination)
    parsed_json = GeocoderService.get_travel_time(origin, destination)
    if parsed_json[:info][:messages].include?('We are unable to route with the given locations.')
      'impossible route'
    else
      parsed_json[:route][:formattedTime]
    end
  end
end
