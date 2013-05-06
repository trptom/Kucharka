require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  setup do
    request.env["HTTP_REFERER"] = "some_page_i_came_from"
    @comment = comments(:one)
    login_user users(:admin)
  end

  teardown do
    logout_user
  end

  test "create" do
    assert_difference('Comment.count') do
      post :create, comment: {
        content: "nejaky obsah o delce alespon 50 znaku 123456789 123456789 123456789",
        user_id: users(:admin).id,
        article_id: articles(:one)
      }
    end

    assert_redirected_to "some_page_i_came_from"
  end

  test "create with wrong atts" do
    assert_difference('Comment.count', 0) do
      post :create, comment: {
        content: "",
        user_id: 0,
        article_id: 0
      }
    end

    assert_response :redirect
  end

  test "destroy" do
    assert_difference('Comment.count', -1) do
      delete :destroy, id: @comment
    end

    assert_redirected_to "some_page_i_came_from"
  end
end
