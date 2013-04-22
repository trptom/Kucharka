# coding:utf-8

require 'test_helper'

class RecipeTest < ActionDispatch::IntegrationTest
  fixtures :all

  test "create new" do
    login_user users(:admin)

    # vlitnu na home
    get "/"
    assert_response :success

    get_via_redirect "/my_recipes"
    assert_response :success
    assert_equal '/my_recipes', path

    get_via_redirect "/recipes/new"
    assert_response :success
    assert_equal '/recipes/new', path

    logout_user
  end

  test "check permissions" do
    # vlitnu na home
    get "/"
    assert_response :success

    get_via_redirect "/my_recipes"
    assert_equal '/home/error', path

    get_via_redirect "/recipes/"+recipes(:one).id.to_s+"/edit"
    assert_equal '/home/error', path

    get_via_redirect new_recipe_path(recipes(:one))
    assert_equal '/home/error', path
  end
end
