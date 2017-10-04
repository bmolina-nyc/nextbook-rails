class Recommender
  def call
    hash = fetch_and_parse_taste_dive
    hash.map do |book|
      fetch_and_parse_google_book(book[:name], book[:author])
    end
  end

  private

  def fetch_and_parse_taste_dive
    url = TasteDiveApi::UrlGenerator::Books.new(['Seveneves', 'Sapiens']).call
    response = Rails.cache.fetch("testing2") { Requester.new(url).call }
    parsed = TasteDiveApi::JsonParser::Books.new(response).call
    TasteDiveApi::ResponseBuilder::Books.new(parsed).call
  end

  def fetch_and_parse_google_book(title, author)
    url = GoogleBooksApi::UrlGenerator::Recommendation.new(title, author).call
    response = Requester.new(url).call
    GoogleBooksApi::JsonParser::Recommendation.new(response).call
  end
end
