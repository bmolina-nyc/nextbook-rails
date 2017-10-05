class V1::BooksController < ApplicationController

  # GET /v1/books
  def index
    render json: books, status: :ok
  end

  private
end
