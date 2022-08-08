class MunchieSerializer

  def self.munchies(weather, food)
    { 
      "data": {
        "id": "null",
        "type": "munchie",
        "attributes": {
          "destination_city": food.city_state,
          "forecast": {
            "summary": weather.conditions,
            "temperature": weather.temperature
          },
          "restaurant": {
            "name": food.name,
            "address": food.address
          }
        }
      }
    }
  end

end