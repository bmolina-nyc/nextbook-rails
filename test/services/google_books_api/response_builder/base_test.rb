require 'test_helper'

class GoogleBooksApi::ResponseBuilder::BaseTest < ActiveSupport::TestCase
  def setup
    @user = users(:linus)
    @hash = {
      id: 'RMd3GpIFxcUC',
      title: 'Snow Crash',
      published_date: '2001-03-01'
    }
    @result = GoogleBooksApi::ResponseBuilder::Base.new(
      @user, @hash
    ).call
  end

  test "should have status key" do
    assert @result.key? 'status'
  end

  test "should have correct status for book marked by user" do
    assert_equal 'liked', @result['status']
  end

  test "should have nil status for book not marked by user" do
    hash = { id: 'NotMarkedByUser' }
    result = GoogleBooksApi::ResponseBuilder::Base.new(@user, hash).call
    assert_nil result['status']
  end

  test "should be in camel case" do
    assert @result.key? 'publishedDate'
  end
end
