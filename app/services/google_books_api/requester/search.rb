class GoogleBooksApi::Requester::Search < RequesterBase
  def initialize(query, **args)
    @query = query
    @args = args
  end

  private

  def generate_url
    GoogleBooksApi::UrlGenerator::Search.new(query, args).call
  end

  attr_reader :query, :args
end
