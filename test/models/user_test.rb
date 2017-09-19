require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should have many user_books" do
    user_books = users(:linus).user_books
    assert_equal user_books.count, 2
    assert_equal user_books.first, user_books(:one)
  end
end
