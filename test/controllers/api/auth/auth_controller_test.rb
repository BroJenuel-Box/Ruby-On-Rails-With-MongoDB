require 'test_helper'

class Api::Auth::AuthControllerTest < ActionDispatch::IntegrationTest
  test "should get login" do
    get api_auth_auth_login_url
    assert_response :success
  end

end
