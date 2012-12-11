require 'test_helper'

class IngredienceCategoryLinksControllerTest < ActionController::TestCase
  setup do
    @ingredience_category_link = ingredience_category_links(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ingredience_category_links)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ingredience_category_link" do
    assert_difference('IngredienceCategoryLink.count') do
      post :create, ingredience_category_link: { note: @ingredience_category_link.note }
    end

    assert_redirected_to ingredience_category_link_path(assigns(:ingredience_category_link))
  end

  test "should show ingredience_category_link" do
    get :show, id: @ingredience_category_link
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ingredience_category_link
    assert_response :success
  end

  test "should update ingredience_category_link" do
    put :update, id: @ingredience_category_link, ingredience_category_link: { note: @ingredience_category_link.note }
    assert_redirected_to ingredience_category_link_path(assigns(:ingredience_category_link))
  end

  test "should destroy ingredience_category_link" do
    assert_difference('IngredienceCategoryLink.count', -1) do
      delete :destroy, id: @ingredience_category_link
    end

    assert_redirected_to ingredience_category_links_path
  end
end
