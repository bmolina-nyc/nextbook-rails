class V1::BooksController < ApplicationController

  # GET /v1/books
  def show
    render json: {books: google_books_lookup}, status: :ok
  end

  private

  def google_books_lookup
    GoogleBooksApi::Lookup.new(params[:id], current_user).call
  end
end
