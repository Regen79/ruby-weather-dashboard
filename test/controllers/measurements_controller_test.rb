require "test_helper"

class MeasurementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @device = devices(:one)
    @user = users(:one)
    post session_path, params: { email_address: @user.email_address, password: "password" }
  end

  test "should get index" do
    get device_measurements_url(@device)
    assert_response :success
  end
end
