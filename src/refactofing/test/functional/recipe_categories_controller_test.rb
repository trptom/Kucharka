require 'test_helper'

class RecipeCategoriesControllerTest < ActionController::TestCase
  setup do
    @recipe_category = recipe_categories(:one)
    login_user users(:admin)
  end

  teardown do
    logout_user
  end

  test "index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:recipe_categories)
  end

  test "new" do
    get :new
    assert_response :success
  end

  test "create" do
    assert_difference('RecipeCategory.count') do
      post :create, recipe_category: { description: @recipe_category.description, name: @recipe_category.name }
    end

    assert_redirected_to recipe_category_path(assigns(:recipe_category))
  end

  test "create with wrong atts" do
    assert_difference('RecipeCategory.count', 0) do
      post :create, recipe_category: { description: "", name: "" }
    end

    assert_response :success
  end

  test "show" do
    get :show, id: @recipe_category
    assert_response :success
  end

  test "edit" do
    get :edit, id: @recipe_category
    assert_response :success
  end

  test "update" do
    put :update, id: @recipe_category, recipe_category: { description: @recipe_category.description, name: @recipe_category.name }
    assert_redirected_to recipe_category_path(assigns(:recipe_category))
  end

  test "update with wrong atts" do
    put :update, id: @recipe_category, recipe_category: {
      description: "",
      name: ""
    }
    assert_response :success
  end

  test "destroy" do
    assert_difference('RecipeCategory.count', -1) do
      delete :destroy, id: @recipe_category
    end

    assert_redirected_to recipe_categories_path
  end
end
