require 'test_helper'

class V1::Books::MyBooks::AlreadyReadControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get v1_books_my_books_already_read_index_url
    assert_response :success
  end

end
