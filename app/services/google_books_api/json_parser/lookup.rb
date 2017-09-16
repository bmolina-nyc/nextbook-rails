class GoogleBooksApi::JsonParser::Lookup < GoogleBooksApi::JsonParser::Base
  def call
    get_item_hash(response)
  end
end
