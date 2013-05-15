require 'test_helper'

class LogsControllerTest < ActionController::TestCase
  setup do
    login_user users(:admin)
  end

  teardown do
    logout_user
  end

  test "index" do
    get :index
    assert_response :success

    assigns :files
  end

  test "show" do
    get :show, file: "test_page_requests.log"
    assert_response :success

    @lines = assigns :lines
    assert @lines.length > 0
  end

  test "detail" do
    get :detail, file: "test_page_requests.log"
    assert_response :success

    @lines = assigns :lines
    assert @lines.length > 0
  end

  test "index access denied" do
    logout_user
    login_user users(:one)

    get :index
    assert_redirected_to "/home/error"
  end

  test "show access denied" do
    logout_user
    login_user users(:one)

    get :show, file: "test_page_requests.log"
    assert_redirected_to "/home/error"
  end

  test "detail access denied" do
    logout_user
    login_user users(:one)

    get :detail, file: "test_page_requests.log"
    assert_redirected_to "/home/error"
  end
end
