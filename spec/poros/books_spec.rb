require 'rails_helper'

RSpec.describe Books do
  describe 'initialize' do
    before(:each) do
      @forecast = { summary: 'Sunny', temperature: 75.0 }
      @books_data = [
        { isbn: '123456', title: 'Book 1' },
        { isbn: '789012', title: 'Book 2' },
      ]
      @total_books_found = 10
      @location = 'denver,co'
    end

    xit 'exists with attributes' do
      books = Books.new(@forecast, @books_data, @total_books_found, @location)
      
    end
  end
end