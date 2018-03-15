require 'test_helper'

class AppointmentsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get appointments_new_url
    assert_response :success
  end

end
