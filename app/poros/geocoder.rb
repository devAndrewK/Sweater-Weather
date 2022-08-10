class Geocoder
  attr_reader :lat, :lng

  def initialize(data)
    @lat = data[:results].first[:locations].first[:latLng][:lat].to_s
    @lng = data[:results].first[:locations].first[:latLng][:lng].to_s
  end
end