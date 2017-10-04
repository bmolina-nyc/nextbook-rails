class V1::BooksController < ApplicationController

  # GET /v1/books
  def index
    books = current_user.book_ids(9).map do |google_id|
      # unless exists_on_client?(google_id)
      parsed = Rails.cache.fetch("lookup-#{google_id}", expires_in: 120.days) do
        parsed = fetch_and_parse(google_id)
      end
      # end
      build_response(parsed)
    end
    render json: books, status: :ok
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
    Requester.new(generate_url(google_id)).call
  end

  def generate_url(google_id)
    klass('UrlGenerator').new(google_id).call
  end

  def parse_json_into_hash(response)
    klass('JsonParser').new(response).call
  end

  def build_response(parsed)
    klass = GoogleBooksApi::ResponseBuilder::Base
    klass.new(current_user, parsed).call
  end

  def klass(module_name)
    "GoogleBooksApi::#{module_name}::Lookup".constantize
  end
end
