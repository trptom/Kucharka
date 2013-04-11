# coding:utf-8

require 'test_helper'

class UserSessionTest < ActionDispatch::IntegrationTest
  fixtures :users

  test "login and logout" do
    # vlitnu na home
    get "/"
    assert_response :success

    # poslu request na prihlaseni
    post_via_redirect "/login", username: users(:admin).username, password: "root"
    assert_response :success
    assert_equal '/', path
    assert_equal 'Prihlašování proběhlo úspěšně.', flash[:notice]

    # odhlasim se
    get_via_redirect "/logout"
    assert_response :success
    assert_equal '/', path
    assert_equal 'Uživatel byl úspěšne odhlášen!', flash[:notice]

    # vlitnu na search a budu doufat, ze pak budu presmerovany na home a ne zpatky
    get "/search"
    assert_response :success

    # poslu request na prihlaseni
    post_via_redirect "/login", username: users(:admin).username, password: "root"
    assert_response :success
    assert_equal '/', path
    assert_equal 'Prihlašování proběhlo úspěšně.', flash[:notice]

    # odhlasim se
    get_via_redirect "/logout"
    assert_response :success
    assert_equal '/', path
    assert_equal 'Uživatel byl úspěšne odhlášen!', flash[:notice]
  end

  test "wrong login" do
    # vlitnu na home
    get "/"
    assert_response :success

    # poslu 4 spatne requesty na prihlaseni
    post_via_redirect "/login", username: users(:admin).username, password: "wrongpassword"
    assert_response :success
    assert_equal '/home/error', path
    assert_equal 'Přihlašování selhalo.', flash[:notice]

    post_via_redirect "/login"
    assert_response :success
    assert_equal '/home/error', path
    assert_equal 'Přihlašování selhalo.', flash[:notice]

    post_via_redirect "/login", username: users(:admin).username
    assert_response :success
    assert_equal '/home/error', path
    assert_equal 'Přihlašování selhalo.', flash[:notice]

    post_via_redirect "/login", password: "wrongpassword"
    assert_response :success
    assert_equal '/home/error', path
    assert_equal 'Přihlašování selhalo.', flash[:notice]
  end
end
