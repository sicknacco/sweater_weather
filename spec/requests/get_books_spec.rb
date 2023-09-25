require 'rails_helper'

RSpec.describe 'Books API', type: :request do
  describe 'GET /api/v1/book-search' do
    it 'can search for books for destination city' do
      location = 'denver,co'
      quantity = 5

      get "/api/v1/book-search?location=#{location}&quantity=#{quantity}"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      books = JSON.parse(response.body, symbolize_names: true)

      expect(books).to be_a(Hash)
      expect(books).to have_key(:data)
      expect(books[:data]).to be_a(Hash)
      
      expect(books[:data]).to have_key(:id)
      expect(books[:data][:id]).to eq(nil)
      expect(books[:data]).to have_key(:type)
      expect(books[:data][:type]).to eq('books')
      expect(books[:data]).to have_key(:attributes)
      expect(books[:data][:attributes]).to be_a(Hash)

      expect(books[:data][:attributes]).to have_key(:destination)
      expect(books[:data][:attributes][:destination]).to be_a(String)
      expect(books[:data][:attributes]).to have_key(:forecast)
      expect(books[:data][:attributes][:forecast]).to be_a(Hash)
      expect(books[:data][:attributes][:forecast]).to have_key(:summary)
      expect(books[:data][:attributes][:forecast][:summary]).to be_a(String)
      expect(books[:data][:attributes][:forecast]).to have_key(:temperature)
      expect(books[:data][:attributes][:forecast][:temperature]).to be_a(Float)

      expect(books[:data][:attributes]).to have_key(:total_books_found)
      expect(books[:data][:attributes][:total_books_found]).to be_a(Integer)

      expect(books[:data][:attributes]).to have_key(:books)
      expect(books[:data][:attributes][:books]).to be_a(Array)

      books[:data][:attributes][:books].each do |book|
        expect(book).to be_a(Hash)
        expect(book).to have_key(:isbn)
        expect(book[:isbn]).to be_an(Array)
        expect(book).to have_key(:title)
        expect(book[:title]).to be_a(String)
      end
    end
  end
end