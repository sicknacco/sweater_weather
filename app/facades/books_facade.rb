class BooksFacade
  def self.search_books(location, quantity)
    coordinates = MapService.city_coordinates(location)
    lat = coordinates[:results][0][:locations][0][:latLng][:lat]
    lon = coordinates[:results][0][:locations][0][:latLng][:lng]
    require 'pry'; binding.pry
    weather = WeatherService.get_weather(location)
    books = BooksService.get_books(location, quantity)
    Books.new(weather, books, location)
  end
end