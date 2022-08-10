class GeocoderFacade
  def self.get_coordinates(location)
    Geocoder.new(GeocoderService.get_coordinates(location))
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
