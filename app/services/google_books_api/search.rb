class GoogleBooksApi::Search
  def initialize(params, user)
    @query = params[:query]
    @page = params[:page]
    @user = user
    @temp = nil
  end

  def call
    @temp = Rails.cache.fetch(cache_key, expires_in: 15.days) do
      generate_url
      make_request
      parse_response
    end
    build_response
  end

  private

  def cache_key
    "GB-SCH-#{query.downcase.strip}#{page || '1'}"
  end

  def generate_url
    @temp = klass('UrlGenerator').new(query, page).call
  end

  def make_request
    @temp = Requester.new(@temp).call
  end

  def parse_response
    @temp = klass('JsonParser').new(@temp).call
  end

  def build_response
    klass('ResponseBuilder').new(user, @temp).call
  end

  def klass(module_name)
    "GoogleBooksApi::#{module_name}::Search".constantize
  end

  attr_reader :query, :page, :user
end
