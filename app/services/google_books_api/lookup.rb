class GoogleBooksApi::Lookup
  def initialize(id, user)
    @id = id
    @user = user
    @temp = nil
  end

  def call
    @temp = Rails.cache.fetch("GB-LKP-#{id}", expires_in: 365.days) do
      generate_url
      make_request
      parse_response
    end
    build_response
  end

  private

  def generate_url
    @temp = klass('UrlGenerator').new(id).call
  end

  def make_request
    @temp = Requester.new(@temp).call
  end

  def parse_response
    @temp = klass('JsonParser').new(@temp).call
  end

  def build_response
    klass('ResponseBuilder', 'Base').new(user, @temp).call
  end

  def klass(module_name, class_name = 'Lookup')
    "GoogleBooksApi::#{module_name}::#{class_name}".constantize
  end

  attr_reader :id, :user
end
