class TasteDiveApi::UrlGenerator::Base
  def initialize(book_titles, limit=DEFAULT_LIMIT)
    @book_titles = book_titles
    @limit = limit
  end

  def call
    "#{BASE_URL}?#{get_params_hash.to_query}"
  end

  private

  # API Constants
  BASE_URL = "https://tastedive.com/api/similar"
  API_KEY = Rails.application.secrets.TASTE_DIVE_API_KEY
  DEFAULT_LIMIT = 6

  def get_params_hash
    {
      q: generate_query,
      limit: limit,
      k: API_KEY
    }
  end

  def generate_query
    book_titles.map { |title| "book:#{title}" }.join(',')
  end

  attr_reader :book_titles, :limit
end
