require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase
  setup do
    @article = Article.first
    login_user users(:admin)
  end

  teardown do
    logout_user
  end

  test "new" do
    get :new
    assert_response :success
  end

  test "create" do
    assert_difference('Article.count') do
      post :create, article: {
        annotation: "123456789 123456789 123456789 123456789 123456789 ",
        content: "
          123456789 123456789 123456789 123456789 123456789 
          123456789 123456789 123456789 123456789 123456789 
          123456789 123456789 123456789 123456789 123456789 
          123456789 123456789 123456789 123456789 123456789 
          123456789 123456789 123456789 123456789 123456789 ",
        title: "test-func"}
    end

    assert_redirected_to article_path(assigns(:article))
  end

  test "create with wrong atts" do
    assert_difference('Article.count', 0) do
      post :create, article: {
        annotation: "0",
        content: "0",
        title: "0"
      }
    end
    assert_response :success
  end

  test "show" do
    get :show, id: @article
    assert_response :success
  end

  test "edit" do
    get :edit, id: @article
    assert_response :success
  end

  test "update" do
    put :update, id: @article, article: {
        annotation: "123456789 123456789 123456789 123456789 123456789 new",
        content: "
          123456789 123456789 123456789 123456789 123456789 
          123456789 123456789 123456789 123456789 123456789 
          123456789 123456789 123456789 123456789 123456789 
          123456789 123456789 123456789 123456789 123456789 
          123456789 123456789 123456789 123456789 123456789 new",
        title: "test-func-new"
    }
    assert_redirected_to @article
  end

  test "update with wrong atts" do
    put :update, id: @article, article: {
        annotation: "0",
        content: "0",
        title: "0"
    }
    assert_response :success
  end


  test "destroy" do
    assert_difference('Article.count', -1) do
      delete :destroy, id: @article
    end

    assert_redirected_to "/my_articles"
  end
end
