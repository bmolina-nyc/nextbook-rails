class V1::Books::RecommendationsController < ApplicationController

  # GET v1/books/recommendations
  def index
    recommendations = []
    if true
      parsed = fetch_and_parse_taste_dive(current_user.liked.latest_titles)
      titles = build_taste_dive_response(parsed)
      Recommender.new(titles, current_user).call
    end
    recommendation_ids.each do |google_id|
      parsed = Rails.cache.fetch("lookup-#{google_id}", expires_in: 120.days) do
        parsed = fetch_and_parse(google_id)
      end
      recommendations << build_response(parsed)
    end
    render json: recommendations, status: :ok
  end

  private

  def fetch_and_parse_taste_dive(titles)
    url = TasteDiveApi::UrlGenerator.new(titles).call
    json = Requester.new(url).call
    TasteDiveApi::JsonParser.new(json).call
  end

  def build_taste_dive_response(titles)
    TasteDiveApi::ResponseBuilder.new(current_user, titles).call
  end

  def find_more_recommendations?
    ShouldFindMoreRecommendations.new(current_user).call
  end

  def recommendation_ids
    current_user.recommendations.pluck(:google_id)
  end

  def fetch_and_parse(id)
    url = klass('UrlGenerator').new(id).call
    json = Requester.new(url).call
    klass('JsonParser').new(json).call
  end

  def build_response(hash)
    GoogleBooksApi::ResponseBuilder::Base.new(current_user, hash).call
  end

  def klass(module_name)
    "GoogleBooksApi::#{module_name}::Lookup".constantize
  end
end
