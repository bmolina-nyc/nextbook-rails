class V1::SearchesController < ApplicationController

  # GET v1/searches
  def index
    parsed = Rails.cache.fetch(
      "#{cache_key}", expires_in: 3.days) do
        fetch_and_parse
    end
    search = build_response(parsed)
    render json: search.as_json, status: :ok
  end

  private

  def cache_key
    "#{searches_params[:query]}-#{searches_params[:start_index]}"
  end

  def fetch_and_parse
    parse_json_into_hash(search)
  end

  def search
    GoogleBooksApi::Requester::Search.new(
      searches_params[:query],
      searches_params[:start_index]
    ).call
  end

  def parse_json_into_hash(json)
    GoogleBooksApi::JsonParser::Search.new(json).call
  end

  def build_response(hash)
    GoogleBooksApi::ResponseBuilder::Search.new(current_user, hash)
  end

  def searches_params
    params.permit(:query, :start_index, :max_results)
  end
end
