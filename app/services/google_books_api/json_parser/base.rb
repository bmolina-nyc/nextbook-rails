class GoogleBooksApi::JsonParser::Base
  include GoogleBooksApi::JsonParser::Selectors

  def initialize(response)
    @response = response
  end

  private

  def get_item_hash(item)
    {
      id: get_google_id(item),
      title: get_title(item),
      subtitle: get_subtitle(item),
      authors: get_authors(item),
      published_date: get_published_date(item),
      thumbnail: remove_image_curl(get_thumbnail(item)),
      page_count: get_page_count(item),
      categories: get_categories(item),
      publisher: get_publisher(item)
    }
  end

  def remove_image_curl(image_url)
    image_url ? image_url.gsub('&edge=curl', '') : nil
  end

  attr_reader :response
end
