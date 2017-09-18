class Recommender
  def initialize(titles, user, limit = LIMIT_DEFAULT)
    @titles = titles
    @user = user
    @limit = limit
  end

  def call
    recommendations = []
    titles.each do |title|
      book = make_google_books_request(title)
      recommendations << book unless marked_by_user?(book['googleId'])
      break if recommendations.length == limit
    end
    recommendations
  end

  private

  LIMIT_DEFAULT = 5

  def make_google_books_request(title)
    url = GoogleBooksApi::UrlGenerator::Recommendation.new(title).call
    response = Requester.new(url).call
    hash = parse_json_into_hash(response)
    build_response(hash)
  end

  def parse_json_into_hash(response)
    GoogleBooksApi::JsonParser::Recommendation.new(response).call
  end

  def build_response(hash)
    GoogleBooksApi::ResponseBuilder::Recommendation.new(hash).call
  end

  def marked_by_user?(google_id)
    user.books.find_by_google_id(google_id)
  end

  attr_reader :titles, :user, :limit
end
