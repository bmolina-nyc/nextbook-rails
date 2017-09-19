require 'test_helper'

class GoogleBooksApi::JsonParser::LookupTest < ActiveSupport::TestCase
  def setup
    filename = "#{Rails.root}/test/services/google_books_api/json_parser/lookup_test.json"
    json = JSON.parse(File.read(filename))
    @parsed = GoogleBooksApi::JsonParser::Lookup.new(json).call
  end

  test "should get hash" do
    assert_kind_of Hash, @parsed
  end

  test "should have thumbnail" do
    assert @parsed.key? :thumbnail
  end

  test "should have description" do
    assert @parsed.key? :description
  end
end
