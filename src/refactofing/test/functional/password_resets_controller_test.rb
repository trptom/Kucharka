require 'test_helper'

class PasswordResetsControllerTest < ActionController::TestCase
  test "should get create with existing mail" do
    get :create, email: "kucharka-root@email.cz"
    assert_response :redirect
    assigns :user
  end

  test "should get create without existing mail" do
    get :create, email: "nonexistingemail"
    assert_response :redirect
    @user = assigns :user
    assert !@user
  end

  test "should get edit" do
    get :create, email: users(:admin).email
    get :edit, id: User.find(users(:admin).id).reset_password_token
    assert_response :success

    @user = assigns :user
    assert_equal users(:admin), @user
  end

  test "update with good pass" do
    get :create, email: users(:admin).email
    put :update, id: users(:admin).id, email: "kucharka-root@email.cz", token: User.find(users(:admin).id).reset_password_token, user: {
      :password => "ababab",
      :password_confirmation => "ababab"
    }
    assert_redirected_to "/home/success"
  end

  test "update with wron pass confirmation" do
    get :create, email: users(:admin).email
    put :update, id: users(:admin).id, email: "kucharka-root@email.cz", token: User.find(users(:admin).id).reset_password_token, user: {
      :password => "ababab",
      :password_confirmation => "ababab2"
    }
    assert_response :success
  end
end
