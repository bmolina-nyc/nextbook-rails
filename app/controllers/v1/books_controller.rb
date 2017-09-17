class V1::BooksController < ApplicationController

  # GET /v1/books
  def index
    @books = current_user.book_ids(15).map do |google_id|
      # next if exists_on_client?(google_id)
      parsed = Rails.cache.fetch("#{google_id}-lookup", expires_in: 30.days) do
        fetch_and_parse(google_id)
      end
      build_response(parsed)
    end
    render json: { books: @books.as_json }, status: :ok
  end

  private

  def exists_on_client?(google_id)
    !!params[:ids] && params[:ids].include?(google_id)
  end

  def fetch_and_parse(google_id)
    response = lookup(google_id)
    parse_json_into_hash(response)
  end

  def lookup(google_id)
    GoogleBooksApi::Requester::Lookup.new(google_id).call
  end

  def parse_json_into_hash(response)
    GoogleBooksApi::JsonParser::Lookup.new(response).call
  end

  def build_response(parsed)
    GoogleBooksApi::ResponseBuilder::Lookup.new(current_user, parsed).call
  end
end
