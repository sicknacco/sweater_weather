require 'rails_helper'

RSpec.describe BookService do
  it 'returns a list of books for a location', :vcr do
    location = 'san diego, ca'
    quantity = 5
    books = BookService.serv_books(location, quantity)

    expect(books).to be_a(Hash)
    expect(books).to have_key(:numFound)
    expect(books[:numFound]).to be_a(Integer)

    expect(books).to have_key(:docs)
    expect(books[:docs]).to be_an(Array)
    expect(books[:docs].count).to eq(quantity)
  end
end