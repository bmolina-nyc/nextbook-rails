class GoogleBooksApi::UrlGenerator::Base
  def call
    "#{base_url}?#{params_hash.to_query}"
  end

  VOLUME_INFO_FIELDS = %w(
    title subtitle imageLinks/thumbnail description
    publishedDate pageCount authors categories publisher
  )

  private

  def params_hash
    { key: API_KEY, fields: fields }
  end

  def base_url
    BASE_URL
  end

  # API Constants
  BASE_URL = 'https://www.googleapis.com/books/v1/volumes'
  API_KEY = Rails.application.secrets.GOOGLE_BOOKS_API_KEY
  PRINT_TYPE = 'books'
end
