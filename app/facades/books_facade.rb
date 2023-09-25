class BooksFacade
  def self.search_books(location, quantity)
    coordinates = MapService.city_coordinates(location)
    lat = coordinates[:results][0][:locations][0][:latLng][:lat]
    lon = coordinates[:results][0][:locations][0][:latLng][:lng]

    weather = WeatherService.current_weather(lat, lon)
    forecast = {
      summary: weather[:current][:condition][:text],
      temperature: weather[:current][:temp_f]
    }

    books = BookService.serv_books(location)
    require 'pry'; binding.pry
    Books.new(weather, books, location)
  end
end