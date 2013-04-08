require 'test_helper'

class MarksControllerTest < ActionController::TestCase
  setup do
    @mark = marks(:one)
    login_user users(:admin)
  end

  teardown do
    logout_user
  end

  test "index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:marks)
  end

  test "destroy" do
    assert_difference('Mark.count', -1) do
      delete :destroy, id: @mark
    end

    assert_redirected_to marks_path
  end

  test "create new" do
    # vytvori novou znamku

    # musim vytvorit novy recept, abych mel jistotu, ze jeste neobsahuje zadnou znamku
    @recipe = Recipe.new(
      :name => "test",
      :content =>
        "obsah o delce alespon 100 1234567890 1234567890 1234567890 1234567890 " +
        "1234567890 1234567890 1234567890 1234567890 1234567890 1234567890 ",
      :user_id => users(:admin).id,
      :estimated_time => 60)
    @recipe.save

    assert_difference('Mark.count', 1) do
      post :create, value: 3, recipe: @recipe.id
    end
    assert_redirected_to @recipe
  end

  test "create existing" do
    # pouze updatuje
    
    # musim prihlasit uzivatele, ktery je evidovan u marks(:one)
    logout_user
    login_user User.find(marks(:one).user_id)

    assert_difference('Mark.count', 0) do
      post :create, value: 1, recipe: marks(:one).recipe_id
    end

    assert Mark.find(marks(:one)).value == 1

    assert_redirected_to Recipe.find(marks(:one).recipe_id)
  end

  test "shouldnt create" do
    # spatne id receptu - dostavam home/error
    post :create, value: 3, recipes: 0
    assert_redirected_to "/home/error"
  end
end
