class YelpFacade
  def self.get_food(location, cuisine)
    json = YelpService.get_food(location, cuisine)
    name = json[:businesses].first[:name]
    address = json[:businesses].first[:location][:display_address]
    Yelp.new(name, address)
  end
end