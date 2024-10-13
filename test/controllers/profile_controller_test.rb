require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest

  test "should get profile" do
    sign_in_as users(:one), "password"
    get profile_path
    assert_response :success
  end

  test "should not get profile if not logged in" do
    get profile_path
    assert_response :redirect
  end
  
  test "should get index" do
    get about_path
    assert_response :success
  end  

end
