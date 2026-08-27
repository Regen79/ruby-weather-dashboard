require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_registration_url
    assert_response :success
  end

  test "should create registration" do
    assert_difference("User.count") do
      post registration_url, params: {
        user: {
          email_address: "test@example.com",
          password: "ComplexPassword123!"
        }
      }
    end

    assert_redirected_to new_session_path
  end
end
