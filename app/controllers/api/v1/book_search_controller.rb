class Api::V1::BookSearchController < ApplicationController
  def index
    book_search = BooksFacade.search_books(params[:location], params[:quantity])
    render json: BookSerializer.new(book_search)
  end
end