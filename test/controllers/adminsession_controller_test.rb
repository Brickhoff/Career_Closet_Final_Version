require 'test_helper'

class AdminsessionControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get adminsession_new_url
    assert_response :success
  end

end
