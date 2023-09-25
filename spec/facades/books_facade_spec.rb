require 'rails_helper'

RSpec.describe BooksFacade do
  it 'can return books and weather for a destination', :vcr do
    location = 'denver,co'
    quantity = 10

    book_results = BooksFacade.search_books(location, quantity)

    expect(book_results).to be_a(Books)
    expect(book_results.id).to eq(nil)
    expect(book_results.type).to eq('books')
    expect(book_results.destination).to eq(location)
    expect(book_results.forecast).to be_a(Hash)
    expect(book_results.forecast[:summary]).to be_a(String)
    expect(book_results.forecast[:temperature]).to be_a(Float)
    expect(book_results.total_books_found).to be_a(Integer)
    expect(book_results.books).to be_a(Array)
    expect(book_results.books.count).to eq(10)
    expect(book_results.books.first).to be_a(Hash)
    expect(book_results.books.first[:isbn]).to be_a(Array)
    expect(book_results.books.first[:title]).to be_a(String)
  end
end