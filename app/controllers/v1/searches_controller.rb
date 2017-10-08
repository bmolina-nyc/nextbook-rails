class V1::SearchesController < ApplicationController

  # GET v1/searches
  def show
    render json: search, status: :ok
  end

  private

  def search
    GoogleBooksApi::Search.new(params, current_user).call
  end

  def searches_params
    params.permit(:query, :page)
  end
end
