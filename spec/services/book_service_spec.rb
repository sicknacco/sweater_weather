require 'rails_helper'

RSpec.describe BookService do
  it 'returns a list of books for a location', :vcr do
    location = 'san diego, ca'
    books = BookService.serv_books(location)

    expect(books).to be_a(Hash)
  end
end