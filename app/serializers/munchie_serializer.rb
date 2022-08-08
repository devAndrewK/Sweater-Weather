class MunchieSerializer

  def self.munchies(weather, food, location)
    { 
      "data": {
      "id": "null",
      "type": "munchie",
      "attributes": {
        "destination_city": location.city,
        "forecast": {
          "summary": weather.conditions,
          "temperature": weather.temperature
        }
        "restaurant": {
          "name": food.name,
          "address": food.address
        }
      }
    }
  }
  end

end