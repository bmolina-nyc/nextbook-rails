require 'test_helper'

class GoogleBooksApi::JsonParser::RecommendationTest < ActiveSupport::TestCase
  def setup
    filename = "#{Rails.root}/test/services/google_books_api/json_parser/recommendation_test.json"
    json = JSON.parse(File.read(filename))
    @parser = GoogleBooksApi::JsonParser::Recommendation.new(json)
  end

  test "should get hash" do
    assert_kind_of Hash, @parser.call
  end
end
