require 'test_helper'

class RecipeArticleLinksControllerTest < ActionController::TestCase
  setup do
    @recipe_article_link = recipe_article_links(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:recipe_article_links)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create recipe_article_link" do
    assert_difference('RecipeArticleLink.count') do
      post :create, recipe_article_link: { note: @recipe_article_link.note }
    end

    assert_redirected_to recipe_article_link_path(assigns(:recipe_article_link))
  end

  test "should show recipe_article_link" do
    get :show, id: @recipe_article_link
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @recipe_article_link
    assert_response :success
  end

  test "should update recipe_article_link" do
    put :update, id: @recipe_article_link, recipe_article_link: { note: @recipe_article_link.note }
    assert_redirected_to recipe_article_link_path(assigns(:recipe_article_link))
  end

  test "should destroy recipe_article_link" do
    assert_difference('RecipeArticleLink.count', -1) do
      delete :destroy, id: @recipe_article_link
    end

    assert_redirected_to recipe_article_links_path
  end
end
