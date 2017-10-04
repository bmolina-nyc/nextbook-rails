class GoogleBooksApi::JsonParser::Recommendation < GoogleBooksApi::JsonParser::Base
  def call
    get_item_hash(response['items'].first)
  end

  private

  def get_item_hash(item)
    {
      id: get_google_id(item),
      title: get_title(item),
      subtitle: get_subtitle(item),
    }
  end
end
