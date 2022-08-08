class YelpService
  def self.get_food(location, cuisine)
    response = BaseService.yelp_connection.get('/v3/businesses/search') do |f|
      f.params['location'] = location
      f.params['term'] = cuisine
      f.params['categories'] = 'restaurant'
      f.headers["Authorization"] = ENV['YELP_KEY']
    end
    BaseService.get_json(response)
  end
end