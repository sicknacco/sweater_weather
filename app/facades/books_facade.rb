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

    books = BookService.serv_books(location, quantity)
    total_books_found = books[:numFound]

    books_data = books[:docs].map do |book|
      {
        isbn: book[:isbn],
        title: book[:title]
      }
    end

    Books.new(forecast, books_data, total_books_found, location)
  end
end