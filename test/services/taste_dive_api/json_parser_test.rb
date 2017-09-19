require 'test_helper'

class TasteDiveApi::JsonParserTest < ActiveSupport::TestCase
  def setup
    filename = "#{Rails.root}/test/services/taste_dive_api/json_parser_test.json"
    json = JSON.parse(File.read(filename))
    @parser = TasteDiveApi::JsonParser.new(json).call
  end

  test "should get titles array" do
    titles = [
      'Words Of Radiance',
      'The Diamond Age',
      'Warbreaker',
      'Anathem',
      'The Stormlight Archive'
    ]

    assert_equal titles, @parser
  end
end
