require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    @user = users(:admin)
    login_user @user
  end

  teardown do
    logout_user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    logout_user

    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { email: "newusermail@example.com", username: "test-create", password: "pass", password_confirmation: "pass" }
    end

    assert_redirected_to "/home/success"
  end

  test "should show user" do
    get :show, {'id' => @user.id}
    assert_response :success
  end

  test "should get edit" do
    get :edit,  {'id' => @user.id}
    assert_response :success
  end

  test "should update user" do
    put :update, {'id' => @user.id}, user: { first_name: "Bob", second_name: "Bobowski" }
    assert_redirected_to @user
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: users(:one)
    end

    assert_redirected_to users_path
  end
end
