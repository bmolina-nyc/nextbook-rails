class GoogleBooksApi::UrlGenerator::Base
  def call
    "#{get_base_url}?#{get_params_hash.to_query}"
  end

  private

  def get_params_hash
    {
      key: API_KEY,
      fields: get_fields
    }
  end

  def get_base_url
    BASE_URL
  end

  def volume_info_full_fields
    'title,subtitle,imageLinks/thumbnail,description,publishedDate,averageRating,ratingsCount,pageCount,authors,categories'
  end

  def volume_info_preview_fields
    'title,subtitle,imageLinks/thumbnail,authors,categories'
  end

  # API Constants
  BASE_URL = 'https://www.googleapis.com/books/v1/volumes'
  API_KEY = Rails.application.secrets.GOOGLE_BOOKS_API_KEY
  PRINT_TYPE = 'books'
end
