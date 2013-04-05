require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  setup do
    login_user users(:admin)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get search" do
    get :search
    assert_response :success
  end

  test "should get error" do
    get :error
    assert_response :success
  end

  test "should get success" do
    get :success
    assert_response :success
  end
end
