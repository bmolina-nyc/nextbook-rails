class GoogleBooksApi::Requester::Recommendation < RequesterBase
  def initialize(title)
    @title = title
  end

  private

  def generate_url
    GoogleBooksApi::UrlGenerator::Recommendation.new(title).call
  end

  attr_reader :title
end
