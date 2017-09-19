require 'test_helper'

class GoogleBooksApi::JsonParser::SearchTest < ActiveSupport::TestCase
  def setup
    filename = "#{Rails.root}/test/services/google_books_api/json_parser/search_test.json"
    json = JSON.parse(File.read(filename))
    @parsed = GoogleBooksApi::JsonParser::Search.new(json).call
  end

  test "should get hash" do
    assert_kind_of Hash, @parsed
  end

  test "should have items" do
    assert @parsed.key? :items
  end

  test "items should be an array" do
    assert_kind_of Array, @parsed[:items]
  end

  test "should have total_items field" do
    assert @parsed.key? :total_items
  end

  test "total_items should be an Integer" do
    assert_kind_of Integer, @parsed[:total_items]
  end
end
