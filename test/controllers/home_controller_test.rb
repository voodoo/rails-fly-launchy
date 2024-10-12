require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get profile_path
    assert_response :redirect
  end
end
