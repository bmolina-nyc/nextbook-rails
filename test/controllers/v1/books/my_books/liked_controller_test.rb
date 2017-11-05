require 'test_helper'

class V1::Books::MyBooks::LikedControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get v1_books_my_books_liked_index_url
    assert_response :success
  end

end
