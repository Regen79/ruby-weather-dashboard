require "test_helper"

class Api::MeasurementsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    post api_measurements_url(format: :json), params: { measurement: { temperature: 20, humidity: 50 } }
    assert_response :success
  end
end
