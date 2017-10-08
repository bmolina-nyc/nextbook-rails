class GoogleBooksApi::Recommendation
  def initialize(title, author)
    @title = title
    @author = author
    @temp = nil
  end

  def call
    Rails.cache.fetch("GB-RCM-#{title}#{author}") do
      generate_url
      make_request
      parse_response
    end
  end

  private

  def generate_url
    @temp = klass('UrlGenerator').new(title, author).call
  end

  def make_request
    @temp = Requester.new(@temp).call
  end

  def parse_response
    @temp = klass('JsonParser').new(@temp).call
  end

  def klass(module_name)
    "GoogleBooksApi::#{module_name}::Recommendation".constantize
  end

  attr_reader :title, :author
end
