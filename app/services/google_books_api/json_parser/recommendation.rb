class GoogleBooksApi::JsonParser::Recommendation < GoogleBooksApi::JsonParser::Base
  def call
    get_item_hash(response['items'].first)
  end
end
