# SWEATER WEATHER

Sweater Weather is a back-end Ruby on Rails application that consumes the MapQuest and Open Weather API and serializes weather and travel JSON data to expose endpoints for a front-end application.

### learning goals

* Expose an endpoint that serializes data from external APIs
* Expose an endpoint that uses an API token
* Expose an endpoint for CRUD functionality

<br>

### API EndPoints

Sweater Weather exposes the following endpoints: 

* GET /api/v1/forecast?location=#{location}</br>
-This endpoint requires the headers {Content-Type: application/json, Accept: application/json}
</br>


-Returns JSON response with hourly, daily and current weather data.

<img width="1009" alt="Screen Shot 2022-08-09 at 7 48 30 PM" src="https://user-images.githubusercontent.com/98759023/183786417-50f26c14-5a30-46d9-bc6e-026e4b9120ad.png">

* POST /api/v1/users</br>
-This endpoint requires the headers {Content-Type: application/json, Accept: application/json}</br>
-Returns API key for use in accessing Trip Weather data</br>
-This endpoint requires data be sent in the body of the request in this format: </br>
{</br>
  "email": "whatever@example.com",</br>
  "password": "password",</br>
  "password_confirmation": "password"</br>
}</br>
<img width="1007" alt="Screen Shot 2022-08-09 at 7 51 17 PM" src="https://user-images.githubusercontent.com/98759023/183786726-29b7973c-0e55-4232-b57a-6516777a6ba8.png">

* POST /api/v1/sessions</br>
-This endpoint requires the headers {Content-Type: application/json, Accept: application/json}</br>
-This endpoint requires data be sent in the body of the request in this format:</br>
{</br>
  "email": "whatever@example.com",</br>
  "password": "password"</br>
}</br>
<img width="1009" alt="Screen Shot 2022-08-09 at 7 52 01 PM" src="https://user-images.githubusercontent.com/98759023/183786765-9ed73883-2e49-4dcc-a298-b0186dde5f4a.png">

* POST /api/v1/road_trip</br>
-This endpoint requires the headers {Content-Type: application/json, Accept: application/json}</br>
-Returns JSON response containing start city, end city, travel time, and weather at estimated time of arrival.</br>
-This endpoint requires data be sent in the body of the request in this format:</br>
{</br>
  "origin": "Denver,CO",</br>
  "destination": "Pueblo,CO",</br>
  "api_key": "api_key_here"</br>
}</br>
<img width="1007" alt="Screen Shot 2022-08-09 at 7 50 21 PM" src="https://user-images.githubusercontent.com/98759023/183786636-6a5893ba-33ef-497a-bd22-09f2b24be215.png">

### How to clone and use Sweater Weather on your local
- Fork and clone this repository. 
- Navigate into sweater_weather and run 'bundle install'
- Next, run 'bundle exec figaro install' in your terminal. 
- Visit https://developer.mapquest.com/documentation/geocoding-api/ to sign up for the MapQuest API key 
- Visit https://openweathermap.org/api/one-call-api to sign up for the OpenWeather API key 
- Put your API keys in the config/application.yml file as follows:
- MAPQUEST_KEY: < mapquest api key >
- WEATHER_KEY: < openweather api key >
- Run 'bundle exec rspec' to run the RSpec test suite 
