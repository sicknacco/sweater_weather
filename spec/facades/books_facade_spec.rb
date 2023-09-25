require 'rails_helper'

RSpec.describe BooksFacade do
  it 'can return books and weather for a destination', :vcr do
    location = 'denver,co'
    quantity = 10

    book_results = BooksFacade.search_books(location, quantity)

    expect(book_results).to be_a(Books)
  end
end