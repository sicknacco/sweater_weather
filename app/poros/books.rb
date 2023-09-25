class Books
  attr_reader :destination,
              :forecast,
              :total_books_found,
              :books,
              :id,
              :type
  def initialize(forecast, books_data, total_books_found, location) 
    @id = nil
    @type = 'books'
    @destination = location
    @forecast = forecast
    @total_books_found = total_books_found
    @books = books_data
    # require 'pry'; binding.pry  ##<<< added to confirm data is being passed in correctly
  end
end