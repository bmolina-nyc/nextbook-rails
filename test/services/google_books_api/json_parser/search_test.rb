require 'test_helper'

class GoogleBooksApi::JsonParser::SearchTest < ActiveSupport::TestCase
  def setup
    filename = "#{Rails.root}/test/services/google_books_api/json_parser/search_test.json"
    json = JSON.parse(File.read(filename))
    @parser = GoogleBooksApi::JsonParser::Search.new(json)
  end

  test "should get hash" do
    assert_kind_of Hash, @parser.call
  end
end
