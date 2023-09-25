require 'rails_helper'

RSpec.describe Books do
  describe 'initialize' do
    it 'exists with attributes' do
      books_data = Books.new("denver,co", {:summary=>"Sunny", :temperature=>80}, 80, [{:isbn=>["0762507845", "9780762507849"], :title=>"Denver, Co"}])
      require 'pry'; binding.pry
    end
  end
end