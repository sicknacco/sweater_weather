[![GitHub contributors](https://img.shields.io/github/contributors/sicknacco/sweater_weather)](https://github.com/sicknacco/sweater_weather/graphs/contributors)
[![GitHub forks](https://img.shields.io/github/forks/sicknacco/sweater_weather)](https://github.com/sicknacco/sweater_weather/forks)
[![GitHub Repo stars](https://img.shields.io/github/stars/sicknacco/sweater_weather)](https://github.com/sicknacco/sweater_weather/stargazers)
[![GitHub issues](https://img.shields.io/github/issues/sicknacco/sweater_weather)](https://github.com/sicknacco/sweater_weather/issues)


# Sweater Weather

## About The Project
Sweater Weather is a rails application that is the final solo project for Turing's mod three back-end program. This project gives current weather information for a given city and the weather for a road trip destination when a user arrives. Sweater Weather is a service-oriented project. We are responsible for consuming four external API endpoints to manipulate and expose them in endpoints for a hypothetical front-end team to consume and present to the end user. The back-end is developed based on JSON contracts and wireframes from our hypothetical front-end team. 

Learn more about this project from the assigment page [here](https://backend.turing.edu/module3/projects/sweater_weather/).

## Learning Goals
- Expose an API that aggregates data from multiple external APIs
- Expose an API that requires an authentication token
- Expose an API for CRUD functionality
- Determine completion criteria based on the needs of other developers
- Test both API consumption and exposure, making use of the mocking tool VCR which ties into Webmock

### Built With:
![Ruby](https://img.shields.io/badge/ruby-%23CC342D.svg?style=for-the-badge&logo=ruby&logoColor=white)
![Postgresql](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
![Rails](https://img.shields.io/badge/rails-%23CC0000.svg?style=for-the-badge&logo=ruby-on-rails&logoColor=white)
![Visual Studio Code](https://img.shields.io/badge/Visual%20Studio%20Code-0078d7.svg?style=for-the-badge&logo=visual-studio-code&logoColor=white)
![Postman Badge](https://img.shields.io/badge/Postman-FF6C37?logo=postman&logoColor=fff&style=for-the-badge)

Sweater Weather is built with these API integerateions
- [Weather API](https://www.weatherapi.com/)
- [MapQuest's Geocoding API](https://developer.mapquest.com/documentation/geocoding-api/)
- [MapQuest’s Directions API](https://developer.mapquest.com/documentation/directions-api/)
- [OpenLibrary API](https://openlibrary.org/developers/api)

## <b>Getting Started</b>

To get a local copy, follow these simple instructions

### <b>Installation</b>

1. Fork the Project
2. Clone the repo 
``` 
git clone git@github.com:your_username/sweater_weather.git 
```
3. Install the gems
```
bundle install
```
4. Create the database
```
rails db:{create,migrate}
```
5. Get API keys from the Weather API and Mapquest<br>
- [Weather API](https://www.weatherapi.com/)
- [MapQuest's Geocoding API](https://developer.mapquest.com/)
6. Add your keys to your credentials file like this:
```
- Run this command to open your credentials file:
  EDITOR="code --wait" bin/rails credentials:edit
  
- Add your API key to the credentials file, formatted something like this:
  mapquest:
  MAPQUEST_API_KEY: 1234567

  weather:
  WEATHER_API_key: 1234567
  
- You can then call on this API key anytime like this!:
  Rails.application.credentials.openai[:MAPQUEST_API_KEY]
```

### Prerequisites
- Ruby Version 3.1.2
- Rails Version 7.0.8

## Testing
 
`bundle exec rspec` will run the entire test suite. *All tests are passing at time of writing with 100% coverage.*

The team tested happy paths, sad paths, and edge cases when needed. Error responses were added where applicable.

## Endpoints

### `GET /api/v0/forecast?location=`

**Request:**

*example*
 ```
GET /api/v0/forecast?location=cincinatti,oh
Content-Type: application/json
Accept: application/json
```

**Response:**

*Example*
```
{
  "data": {
    "id": null,
    "type": "forecast",
    "attributes": {
      "current_weather": {
        "last_updated": "2023-04-07 16:30",
        "temperature": 55.0,
        etc
      },
      "daily_weather": [
        {
          "date": "2023-04-07",
          "sunrise": "07:13 AM",
          etc
        },
        {...} etc
      ],
      "hourly_weather": [
        {
          "time": "14:00",
          "temperature": 54.5,
          etc
        },
        {...} etc
      ]
    }
  }
}
```

### `POST /api/v0/users`
**Request:**

*Example*
```
{
  "email": "whatever@example.com",
  "password": "password",
  "password_confirmation": "password"
}
```
**Response:**

*Example*
```
status: 201
body:

{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "email": "whatever@example.com",
      "api_key": "t1h2i3s4_i5s6_l7e8g9i10t11"
    }
  }
}
```

### `POST /api/v0/sessions`
**Request:**

*example*
```
POST /api/v0/sessions
Content-Type: application/json
Accept: application/json

{
  "email": "whatever@example.com",
  "password": "password"
}
```

**Response:**

*example*
```
status: 200
body:

{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "email": "whatever@example.com",
      "api_key": "t1h2i3s4_i5s6_l7e8g9i10t11"
    }
  }
}
```
### `POST /api/v0/road_trip`

**Request:**

*example*
```
POST /api/v0/road_trip
Content-Type: application/json
Accept: application/json

body:

{
  "origin": "Cincinatti,OH",
  "destination": "Chicago,IL",
  "api_key": "t1h2i3s4_i5s6_l7e8g9i10t11"
}
```

**Response:**

*example*
```
{
    "data": {
        "id": "null",
        "type": "road_trip",
        "attributes": {
            "start_city": "Cincinatti, OH",
            "end_city": "Chicago, IL",
            "travel_time": "04:40:45",
            "weather_at_eta": {
                "datetime": "2023-04-07 23:00",
                "temperature": 44.2,
                "condition": "Cloudy with a chance of meatballs"
            }
        }
    }
}
```