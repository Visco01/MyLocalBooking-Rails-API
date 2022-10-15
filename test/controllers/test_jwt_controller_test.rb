require "test_helper"

class TestJwtControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get test_jwt_index_url
    assert_response :success
  end
end
