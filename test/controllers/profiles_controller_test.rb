require "test_helper"

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    post session_path, params: { email_address: @user.email_address, password: "password" }
  end
  test "should get show" do
    get profile_url
    assert_response :success
  end
end
