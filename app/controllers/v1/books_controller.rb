class V1::BooksController < ApplicationController

  # GET /v1/books
  def index
      @books = current_user.book_ids(10).map do |google_id|
      next if params[:id] && params[:ids].includes(google_id)
      response = lookup(google_id)
      hash = parse_json_into_hash(response)
      build_response(hash)
    end
    render json: { books: @books.as_json }, status: :ok
  end

  private

  def lookup(google_id)
    GoogleBooksApi::Requester::Lookup.new(google_id).call
  end

  def parse_json_into_hash(response)
    GoogleBooksApi::JsonParser::Lookup.new(response).call
  end

  def build_response(hash)
    GoogleBooksApi::ResponseBuilder::Lookup.new(current_user, hash).call
  end
end
