require 'test_helper'

class V1::Books::MyBooks::DislikedControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get v1_books_my_books_disliked_index_url
    assert_response :success
  end

end
