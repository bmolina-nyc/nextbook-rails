class V1::Books::RecommendationsController < ApplicationController

  # GET v1/books/recommendations
  def index
    render json: recommendations, status: :ok
  end

  private

  def recommendations
    recommendation_ids.map { |id| google_books_lookup(id) }
  end

  def google_books_lookup(id)
    GoogleBooksApi::Lookup.new(id, current_user)
  end

  def recommendation_ids
    current_user.recommended_books.ids
  end
end
