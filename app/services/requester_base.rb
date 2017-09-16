class RequesterBase
  require 'net/http'
  class ExternalServiceError < StandardError; end

  def call
    url = generate_url
    make_request(url)
  end

  private

  def make_request(url)
    uri = URI(url)
    res = Net::HTTP.get_response(uri)
    raise ExternalServiceError if res.code =~ /4\d\d/
    JSON.parse(res.body)
  end

  attr_reader :params
end
