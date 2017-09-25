class V1::BooksController < ApplicationController

  # GET v1/books
  def show
    url = GoogleBooksApi::UrlGenerator::Lookup.new(params[:id]).call
    response = Requester.new(url).call
    parsed = GoogleBooksApi::JsonParser::Lookup.new(response).call

    render json: camelize_keys(parsed), status: :ok
  end
end
