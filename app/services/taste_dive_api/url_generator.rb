class TasteDiveApi::UrlGenerator
  def initialize(title, limit=DEFAULT_LIMIT)
    @title = title
    @limit = limit
  end

  def call
    "#{BASE_URL}?#{get_params_hash.to_query}"
  end

  private

  # API Constants
  BASE_URL = "https://tastedive.com/api/similar"
  API_KEY = Rails.application.secrets.TASTE_DIVE_API_KEY
  TYPE = 'books'
  DEFAULT_LIMIT = 4

  def get_params_hash
    {
      q: generate_query,
      type: TYPE,
      limit: limit,
      k: API_KEY
    }
  end

  def generate_query
    "book:#{title}"
  end

  attr_reader :title, :limit
end
