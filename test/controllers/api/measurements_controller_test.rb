require "test_helper"

class Api::MeasurementsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get api_measurements_create_url
    assert_response :success
  end
end
