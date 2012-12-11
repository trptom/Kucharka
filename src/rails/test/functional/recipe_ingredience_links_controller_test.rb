require 'test_helper'

class RecipeIngredienceLinksControllerTest < ActionController::TestCase
  setup do
    @recipe_ingredience_link = recipe_ingredience_links(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:recipe_ingredience_links)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create recipe_ingredience_link" do
    assert_difference('RecipeIngredienceLink.count') do
      post :create, recipe_ingredience_link: { importance: @recipe_ingredience_link.importance, note: @recipe_ingredience_link.note, quantity: @recipe_ingredience_link.quantity }
    end

    assert_redirected_to recipe_ingredience_link_path(assigns(:recipe_ingredience_link))
  end

  test "should show recipe_ingredience_link" do
    get :show, id: @recipe_ingredience_link
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @recipe_ingredience_link
    assert_response :success
  end

  test "should update recipe_ingredience_link" do
    put :update, id: @recipe_ingredience_link, recipe_ingredience_link: { importance: @recipe_ingredience_link.importance, note: @recipe_ingredience_link.note, quantity: @recipe_ingredience_link.quantity }
    assert_redirected_to recipe_ingredience_link_path(assigns(:recipe_ingredience_link))
  end

  test "should destroy recipe_ingredience_link" do
    assert_difference('RecipeIngredienceLink.count', -1) do
      delete :destroy, id: @recipe_ingredience_link
    end

    assert_redirected_to recipe_ingredience_links_path
  end
end
