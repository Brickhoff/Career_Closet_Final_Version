require 'test_helper'

class SuitsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get suits_new_url
    assert_response :success
  end

  test "should get index" do
    get suits_index_url
    assert_response :success
  end

  test "should get show" do
    get suits_show_url
    assert_response :success
  end

  test "should get edit" do
    get suits_edit_url
    assert_response :success
  end

end
