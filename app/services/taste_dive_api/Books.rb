class TasteDiveApi::Books
  def initialize(titles)
    @titles = titles
    @temp = nil
  end

  def call
    generate_url
    make_request
    parse_response
    build_response
  end

  private

  def generate_url
    @temp = klass('UrlGenerator').new(titles).call
  end

  def make_request
    @temp = Requester.new(@temp).call
  end

  def parse_response
    @temp = klass('JsonParser').new(@temp).call
  end

  def build_response
    klass('ResponseBuilder').new(@temp).call
  end

  def klass(module_name)
    "TasteDiveApi::#{module_name}::Books".constantize
  end

  attr_reader :titles
end
