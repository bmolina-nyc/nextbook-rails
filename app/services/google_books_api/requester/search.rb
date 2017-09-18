class GoogleBooksApi::Requester::Search < RequesterBase
  def initialize(query, start_index)
    @query = query
    @start_index = start_index
  end

  private

  def generate_url
    GoogleBooksApi::UrlGenerator::Search.new(
      query, start_index).call
  end

  attr_reader :query, :start_index
end
