class GoogleBooksApi::JsonParser::Recommendation < GoogleBooksApi::JsonParser::Base
  def call
    get_item_hash(response['items'].first)
  end

  private

  def get_item_hash(item)
    super.merge(description: get_preview(item))
  end
end
