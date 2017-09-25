class V1::RecommendationsController < ApplicationController

  # GET v1/recommendations
  def index
    books = Rails.cache.fetch(
      "#{params[:title].downcase}-Rec", expires_in: 10.days) do
      titles_array = fetch_and_parse_recommendations(params[:title])
      books = []
      titles_array.map do |title|
        books << fetch_and_parse_from_google_books_api(title)
        break if books.length == 3
      end
      books
    end

    render json: camelize_books(books), status: :ok
  end

  private

  def fetch_and_parse_recommendations(title)
    url = TasteDiveApi::UrlGenerator.new(title).call
    response = Requester.new(url).call
    TasteDiveApi::JsonParser.new(response).call
  end

  def fetch_and_parse_from_google_books_api(title)
    url = GoogleBooksApi::UrlGenerator::Recommendation.new(title).call
    response = Requester.new(url).call
    GoogleBooksApi::JsonParser::Recommendation.new(response).call
  end

  def camelize_books(books)
    books.map { |book| camelize_keys(book)}
  end
end
