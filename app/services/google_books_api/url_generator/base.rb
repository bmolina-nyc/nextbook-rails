class GoogleBooksApi::UrlGenerator::Base
  def call
    "#{get_base_url}?#{get_params_hash.to_query}"
  end

  VOLUME_INFO_FIELDS = %w(
    title subtitle imageLinks/thumbnail description
    publishedDate pageCount authors categories publisher
  )

  private

  def get_params_hash
    { key: API_KEY, fields: get_fields }
  end

  def get_base_url
    BASE_URL
  end

  # API Constants
  BASE_URL = 'https://www.googleapis.com/books/v1/volumes'
  API_KEY = Rails.application.secrets.GOOGLE_BOOKS_API_KEY
  PRINT_TYPE = 'books'
end
