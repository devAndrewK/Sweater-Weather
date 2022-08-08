class Yelp
  attr_reader :name, :address, :city_state

  def initialize(name, location)
    @name = name
    @address = location.join(" ")
    @city_state = location[1].split[0..1].join(" ")
  end
end