class Requester
  require 'net/http'
  class ExternalServiceError < StandardError; end

  def initialize(url)
    @url = url
  end

  def call
    make_request(url)
  end

  private

  def make_request(url)
    uri = URI(url)
    res = Net::HTTP.get_response(uri)
    raise ExternalServiceError if res.code =~ /(4|5)\d\d/
    JSON.parse(res.body)
  end

  attr_reader :url
end
