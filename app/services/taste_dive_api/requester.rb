class TasteDiveApi::Requester < RequesterBase
  def initialize(user)
    @user = user
  end

  def call
    book_titles = get_latest_book_titles_for_user
    url = generate_url(book_titles)
    json = make_request(url)
    hash = parse_json_into_array(json)
    build_response(hash)
  end

  private

  def build_response(titles)
    TasteDiveApi::ResponseBuilder.new(user, titles).call
  end

  def parse_json_into_array(json)
    TasteDiveApi::JsonParser.new(json).call
  end

  def generate_url(titles)
    TasteDiveApi::UrlGenerator.new(titles).call
  end

  def get_latest_book_titles_for_user
    user.books.latest_titles
  end

  attr_reader :user
end
