class V1::SearchesController < ApplicationController

  # GET v1/searches
  def index
    parsed = Rails.cache.fetch("#{cache_key}", expires_in: 3.days) do
      parse_json_into_hash(search)
    end
    search = build_response(parsed)
    render json: search, status: :ok
  end

  private

  def cache_key
    "#{searches_params[:query]}-#{searches_params[:start_index]}"
  end

  def search
    Requester.new(generate_url).call
  end

  def generate_url
    klass('UrlGenerator').new(
      searches_params[:query],
      searches_params[:start_index]
    ).call
  end

  def parse_json_into_hash(json)
    klass('JsonParser').new(json).call
  end

  def build_response(hash)
    klass('ResponseBuilder').new(current_user, hash).call
  end

  def searches_params
    snake_params.permit(:query, :start_index)
  end

  def klass(module_name)
    "GoogleBooksApi::#{module_name}::Search".constantize
  end
end