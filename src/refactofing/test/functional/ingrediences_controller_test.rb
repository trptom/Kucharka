require 'test_helper'

class IngrediencesControllerTest < ActionController::TestCase
  setup do
    @ingredience = ingrediences(:one)
    login_user users(:admin)
  end

  teardown do
    logout_user
  end

  test "index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ingrediences_accepted)
    assert_not_nil assigns(:ingrediences_pending)
  end

  test "new" do
    get :new
    assert_response :success
  end

  test "create" do
    assert_difference('Ingredience.count') do
      post :create, ingredience: {
        annotation: @ingredience.annotation,
        avaliability: @ingredience.avaliability,
        content: @ingredience.content,
        name: "test-func",
        units: @ingredience.units
      }
    end

    assert_redirected_to ingredience_path(assigns(:ingredience))
  end

  test "show" do
    get :show, id: @ingredience
    assert_response :success
  end

  test "edit" do
    get :edit, id: @ingredience
    assert_response :success
  end

  test "update" do
    put :update, id: @ingredience, ingredience: { annotation: @ingredience.annotation, avaliability: @ingredience.avaliability, content: @ingredience.content, name: @ingredience.name }
    assert_redirected_to ingredience_path(assigns(:ingredience))
  end

  test "destroy" do
    assert_difference('Ingredience.count', -1) do
      delete :destroy, id: @ingredience
    end

    assert_redirected_to ingrediences_path
  end
end
