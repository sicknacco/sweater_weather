require 'rails_helper'

RSpec.describe Books do
  describe 'initialize' do
    it 'exists with attributes' do
      forecast = { summary: 'Sunny', temperature: 75.0 }
      books_data = [
        { isbn: '123456', title: 'Book 1' },
        { isbn: '789012', title: 'Book 2' },
      ]
      total_books_found = 10
      location = 'denver,co'

      books = Books.new(forecast, books_data, total_books_found, location)
      # require 'pry'; binding.pry
      expect(books).to be_a(Books)
      expect(books.id).to eq(nil)
      expect(books.type).to eq('books')
      expect(books.destination).to eq(location)
      expect(books.forecast).to be_a(Hash)
      expect(books.forecast[:summary]).to be_a(String)
      expect(books.forecast[:temperature]).to be_a(Float)
      expect(books.total_books_found).to be_a(Integer)
      expect(books.books).to be_a(Array)
      expect(books.books.count).to eq(2)
      expect(books.books.first).to be_a(Hash)
      expect(books.books.first[:isbn]).to be_a(String)
      expect(books.books.first[:isbn]).to eq('123456')
      
      expect(books.books.first[:title]).to be_a(String)
      expect(books.books.first[:title]).to eq('Book 1')
    end
  end
end