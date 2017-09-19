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
      thumbnail: get_image_link(item),
      page_count: get_page_count(item),
      ratings_count: get_ratings_count(item),
      average_rating: get_average_rating(item),
      categories: get_genres(item)
    }
  end

  attr_reader :response
end
