class GoogleBooksApi::JsonParser::Lookup < GoogleBooksApi::JsonParser::Base
  def call
    get_item_hash(response)
  end

  private

  def get_item_hash
    super.merge(description: get_description(item))
  end
end
