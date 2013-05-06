require 'test_helper'

class IngredienceCategoriesControllerTest < ActionController::TestCase
  setup do
    @ingredience_category = ingredience_categories(:one)
    login_user users(:admin)
  end

  teardown do
    logout_user
  end

  test "index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ingredience_categories)
  end

  test "new" do
    get :new
    assert_response :success
  end

  test "create" do
    assert_difference('IngredienceCategory.count') do
      post :create, ingredience_category: { description: @ingredience_category.description, name: @ingredience_category.name }
    end

    assert_redirected_to ingredience_category_path(assigns(:ingredience_category))
  end

  test "create with wrong atts" do
    assert_difference('IngredienceCategory.count', 0) do
      post :create, ingredience_category: { description: "", name: "" }
    end

    assert_response :success
  end

  test "show" do
    get :show, id: @ingredience_category
    assert_response :success
  end

  test "edit" do
    get :edit, id: @ingredience_category
    assert_response :success
  end

  test "update" do
    put :update, id: @ingredience_category, ingredience_category: { description: @ingredience_category.description, name: @ingredience_category.name }
    assert_redirected_to ingredience_category_path(assigns(:ingredience_category))
  end

  test "update with wrong atts" do
    put :update, id: @ingredience_category, ingredience_category: { description: "", name: "" }
    assert_response :success
  end

  test "destroy" do
    assert_difference('IngredienceCategory.count', -1) do
      delete :destroy, id: @ingredience_category
    end

    assert_redirected_to ingredience_categories_path
  end
end
