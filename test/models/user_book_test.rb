require 'test_helper'

class UserBookTest < ActiveSupport::TestCase
  test "should belong to a user" do
    user = user_books(:one).user
    assert_equal user, users(:linus)
  end
end
