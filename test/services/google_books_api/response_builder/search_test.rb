require 'test_helper'

class GoogleBooksApi::ResponseBuilder::SearchTest < ActiveSupport::TestCase
  def setup
    @user = users(:linus)
    @hash = {
      total_items: 1000,
      items: [
        {
          id: 'RMd3GpIFxcUC', title: 'Snow Crash', published_date: '2001-03-01'
        },
        {
          id: 'unMarked', title: 'title', published_date: '2000-03-01'
        }
      ]
    }
    @result = GoogleBooksApi::ResponseBuilder::Search.new(@user, @hash).call
  end

  test "should have status key" do
    assert @result['items'].first.key? 'status'
  end

  test "should have correct status for book marked by user" do
    assert_equal 'liked', @result['items'].first['status']
  end

  test "should have nil status for book not marked by user" do
    assert_nil @result['items'].second['status']
  end

  test "should be in camel case" do
    assert @result.key? 'totalItems'
    assert @result['items'].first.key? 'publishedDate'
  end
end
