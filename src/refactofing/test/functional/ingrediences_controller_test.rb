require 'test_helper'

class IngrediencesControllerTest < ActionController::TestCase
  setup do
    @ingredience = ingrediences(:one)
    login_user users(:admin)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ingrediences_accepted)
    assert_not_nil assigns(:ingrediences_pending)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ingredience" do
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

  test "should show ingredience" do
    get :show, id: @ingredience
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ingredience
    assert_response :success
  end

  test "should update ingredience" do
    put :update, id: @ingredience, ingredience: { annotation: @ingredience.annotation, avaliability: @ingredience.avaliability, content: @ingredience.content, name: @ingredience.name }
    assert_redirected_to ingredience_path(assigns(:ingredience))
  end

  test "should destroy ingredience" do
    assert_difference('Ingredience.count', -1) do
      delete :destroy, id: @ingredience
    end

    assert_redirected_to ingrediences_path
  end
end
