require 'test_helper'

class MarksControllerTest < ActionController::TestCase
  setup do
    @mark = marks(:one)
    login_user users(:admin)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:marks)
  end

  test "should create mark" do
    # spravne id receptu - dostavam stranku receptu
    post :create, value: 3, recipe: recipes(:one).id
    assert_redirected_to recipe_path(recipes(:one))
  end

  test "shouldnt create mark" do
    # spatne id receptu - dostavam home/error
    post :create, value: 3, recipes: 0
    assert_redirected_to "/home/error"
  end

  test "should destroy mark" do
    assert_difference('Mark.count', -1) do
      delete :destroy, id: @mark
    end

    assert_redirected_to marks_path
  end
end
