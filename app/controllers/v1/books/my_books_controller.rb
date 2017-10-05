class V1::Books::MyBooksController < ApplicationController

  # GET v1/books/my_books
  def index
    render json: my_books, status: :ok
  end

  private

  def my_books
    my_books_ids.map { |id| google_books_lookup(id) }
  end

  def google_books_lookup(id)
    GoogleBooksApi::Lookup.new(id, current_user).call
  end

  def my_books_ids
    current_user.marked_books.ids
  end
end
