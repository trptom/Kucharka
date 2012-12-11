require 'test_helper'

class RecipeCategoryLinksControllerTest < ActionController::TestCase
  setup do
    @recipe_category_link = recipe_category_links(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:recipe_category_links)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create recipe_category_link" do
    assert_difference('RecipeCategoryLink.count') do
      post :create, recipe_category_link: { note: @recipe_category_link.note }
    end

    assert_redirected_to recipe_category_link_path(assigns(:recipe_category_link))
  end

  test "should show recipe_category_link" do
    get :show, id: @recipe_category_link
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @recipe_category_link
    assert_response :success
  end

  test "should update recipe_category_link" do
    put :update, id: @recipe_category_link, recipe_category_link: { note: @recipe_category_link.note }
    assert_redirected_to recipe_category_link_path(assigns(:recipe_category_link))
  end

  test "should destroy recipe_category_link" do
    assert_difference('RecipeCategoryLink.count', -1) do
      delete :destroy, id: @recipe_category_link
    end

    assert_redirected_to recipe_category_links_path
  end
end
