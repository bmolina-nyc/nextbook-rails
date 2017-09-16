class GoogleBooksApi::JsonParser::Base
  include GoogleBooksApi::JsonParser::Selectors

  def initialize(response)
    @response = response
  end

  private

  def get_item_hash(item)
    {
      google_id: get_google_id(item),
      title: get_title(item),
      subtitle: get_subtitle(item),
      authors: get_authors(item),
      published_date: get_published_date(item),
      description: get_description(item),
      image_link: get_image_link(item),
      page_count: get_page_count(item),
      rating_count: get_ratings_count(item),
      avg_rating: get_average_rating(item),
      genres: get_genres(item),
      text_preview: get_text_preview(item)
    }
  end

  def get_error
    response['error']['code']
  end

  attr_reader :response
end
