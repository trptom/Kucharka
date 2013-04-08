require 'test_helper'

class UserSessionsControllerTest < ActionController::TestCase

  test "should create" do
    post :create, username: "admin", password: "root"
    assert_redirected_to "/"
  end

  test "should destroy" do
    login_user users(:admin)

    post :destroy
    assert_redirected_to "/"

    logout_user
  end

  test "create without params" do
    # melo bz vratit home/error, ne spadnout
    post :create
    assert_redirected_to "/home/error"
  end

end
