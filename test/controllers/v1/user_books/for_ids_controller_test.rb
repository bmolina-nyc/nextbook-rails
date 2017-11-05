require 'test_helper'

class V1::UserBooks::ForIdsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get v1_user_books_for_ids_index_url
    assert_response :success
  end

end
