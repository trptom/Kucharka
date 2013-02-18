require 'test_helper'

class IngredienceCategoriesControllerTest < ActionController::TestCase
  setup do
    @ingredience_category = ingredience_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ingredience_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ingredience_category" do
    assert_difference('IngredienceCategory.count') do
      post :create, ingredience_category: { description: @ingredience_category.description, name: @ingredience_category.name }
    end

    assert_redirected_to ingredience_category_path(assigns(:ingredience_category))
  end

  test "should show ingredience_category" do
    get :show, id: @ingredience_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ingredience_category
    assert_response :success
  end

  test "should update ingredience_category" do
    put :update, id: @ingredience_category, ingredience_category: { description: @ingredience_category.description, name: @ingredience_category.name }
    assert_redirected_to ingredience_category_path(assigns(:ingredience_category))
  end

  test "should destroy ingredience_category" do
    assert_difference('IngredienceCategory.count', -1) do
      delete :destroy, id: @ingredience_category
    end

    assert_redirected_to ingredience_categories_path
  end
end
