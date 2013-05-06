require 'test_helper'

class RecipesControllerTest < ActionController::TestCase
  setup do
    @recipe = recipes(:one)
    login_user users(:admin)
  end

  teardown do
    logout_user
  end

  test "show" do
    get :show, id: @recipe
    assert_response :success
  end

  test "new" do
    get :new
    assert_response :success
  end

  test "create" do
    assert_difference('Recipe.count') do
      post :create, recipe: {
        :name => @recipe.name,
        :annotation => @recipe.annotation,
        :content => @recipe.content,
        :user_id => @recipe.user_id,
        :estimated_time => @recipe.estimated_time}
    end

    assert_redirected_to recipe_path(assigns(:recipe))
  end

  test "create with wrong atts" do
    assert_difference('Recipe.count', 0) do
      post :create, recipe: {
        :name => ""
      }
    end

    assert_response :success
  end

  test "update" do
    put :update, id: @recipe, recipe: {
        :name => "test-func-new"
    }
    assert_redirected_to @recipe
  end

  test "update with wrong atts" do
    put :update, id: @recipe, recipe: {
        :name => ""
    }
    assert_response :success
  end

  test "edit" do
    get :edit, id: @recipe
    assert_response :success
  end

  test "destroy" do
    assert_difference('Recipe.count', -1) do
      delete :destroy, id: @recipe
    end

    assert_redirected_to "/my_recipes"
  end

  test "add_ingredience new" do
    assert_difference('@recipe.ingrediences.count', 1) do
      get :add_ingredience, id: @recipe.id, ingredience: ingrediences(:nowhere_used).id, quantity: "10", importance: 1
    end

    # kontrola nastaveni spravneho mnozstvi
    assert @recipe.ingredienceRecipeConnectors.where(:ingredience_id => ingrediences(:nowhere_used).id).first.quantity == 10
    assert_redirected_to @recipe
  end

  test "add_ingredience new json" do
    assert_difference('@recipe.ingrediences.count', 1) do
      get :add_ingredience, id: @recipe.id, ingredience: ingrediences(:nowhere_used).id, quantity: "10", importance: 1, format: :json
    end

    # kontrola nastaveni spravneho mnozstvi
    assert @recipe.ingredienceRecipeConnectors.where(:ingredience_id => ingrediences(:nowhere_used).id).first.quantity == 10
    assert_response :success
  end

  test "add_ingredience existing" do
    @connector = IngredienceRecipeConnector.first
    @connector.quantity = 1 # kdyby nahodou bylo null - plan do budoucnosti je povolit null hodnoty
    @connector.save

    assert_difference('IngredienceRecipeConnector.count', 0) do
      get :add_ingredience, id: @connector.recipe_id, ingredience: @connector.ingredience_id, quantity: "1.1", importance: 1
    end
    
    # musim nacist znova, protoze activerecord neaktualizuje automaticky hodnoty z DB
    @connector = IngredienceRecipeConnector.find(@connector.id)
    assert @connector.quantity == 2.1

    assert_redirected_to @recipe

    # jeste to vyskousim pro des. cislo s carkou
    assert_difference('IngredienceRecipeConnector.count', 0) do
      get :add_ingredience, id: @connector.recipe_id, ingredience: @connector.ingredience_id, quantity: "1,1", importance: 1
    end

    # musim nacist znova, protoze activerecord neaktualizuje automaticky hodnoty z DB
    @connector = IngredienceRecipeConnector.find(@connector.id)
    assert @connector.quantity == 3.2

    assert_redirected_to @recipe
  end

  test "remove_ingredience" do
    @connector = IngredienceRecipeConnector.first # vyberu nahodne connector
    @recipe = @connector.recipe # zapamatuju si recept, kam mam vyt presmerovan

    assert_difference('IngredienceRecipeConnector.count', -1) do
      get :remove_ingredience, id: @recipe.id, connector_id: @connector.id
    end

    assert_redirected_to @recipe
  end

  test "remove_ingredience json" do
    @connector = IngredienceRecipeConnector.first # vyberu nahodne connector
    @recipe = @connector.recipe # zapamatuju si recept, kam mam vyt presmerovan

    assert_difference('IngredienceRecipeConnector.count', -1) do
      get :remove_ingredience, id: @recipe.id, connector_id: @connector.id, format: :json
    end

    assert_response :success
  end

  test "add and remove category" do
    # pridam novou
    assert_difference('@recipe.recipeCategories.count', 1) do
      get :add_category, id: @recipe.id, category: recipe_categories(:nowhere_used)
    end
    assert_redirected_to @recipe

    # smazu pridanou
    assert_difference('@recipe.recipeCategories.count', -1) do
      get :remove_category, id: @recipe.id, category: recipe_categories(:nowhere_used)
    end
    assert_redirected_to @recipe
  end

  test "add and remove category json" do
    # pridam novou
    assert_difference('@recipe.recipeCategories.count', 1) do
      get :add_category, id: @recipe.id, category: recipe_categories(:nowhere_used), format: :json
    end
    assert_response :success

    # smazu pridanou
    assert_difference('@recipe.recipeCategories.count', -1) do
      get :remove_category, id: @recipe.id, category: recipe_categories(:nowhere_used), format: :json
    end
    assert_response :success
  end

  test "add and remove subrecipe" do
    # pridam novou
    assert_difference('@recipe.subrecipes.count', 1) do
      get :add_subrecipe, id: @recipe.id, subrecipe: "http://xxx.com/recipes/"+recipes(:nowhere_used).id.to_s#recipe_path(recipes(:nowhere_used))
    end
    assert_redirected_to @recipe

    # smazu pridanou
    assert_difference('@recipe.subrecipes.count', -1) do
      get :remove_subrecipe, id: @recipe.id, subrecipe: recipes(:nowhere_used)
    end
    assert_redirected_to @recipe
  end

  test "add and remove subrecipe json" do
    # pridam novou
    assert_difference('@recipe.subrecipes.count', 1) do
      get :add_subrecipe, id: @recipe.id, subrecipe: "http://xxx.com/recipes/"+recipes(:nowhere_used).id.to_s, format: :json#recipe_path(recipes(:nowhere_used))
    end
    assert_response :success

    # smazu pridanou
    assert_difference('@recipe.subrecipes.count', -1) do
      get :remove_subrecipe, id: @recipe.id, subrecipe: recipes(:nowhere_used), format: :json
    end
    assert_response :success
  end

  test "add and remove article" do
    # pridam novou
    assert_difference('@recipe.articles.count', 1) do
      get :add_connected_article, id: @recipe.id, article: "http://xxx.com/articles/"+articles(:nowhere_used).id.to_s#article_path(articles(:nowhere_used))
    end
    assert_redirected_to @recipe

    # smazu pridanou
    assert_difference('@recipe.articles.count', -1) do
      get :remove_connected_article, id: @recipe.id, article: articles(:nowhere_used)
    end
    assert_redirected_to @recipe
  end

  test "add and remove article json" do
    # pridam novou
    assert_difference('@recipe.articles.count', 1) do
      get :add_connected_article, id: @recipe.id, article: "http://xxx.com/articles/"+articles(:nowhere_used).id.to_s, format: :json#article_path(articles(:nowhere_used))
    end
    assert_response :success

    # smazu pridanou
    assert_difference('@recipe.articles.count', -1) do
      get :remove_connected_article, id: @recipe.id, article: articles(:nowhere_used), format: :json
    end
    assert_response :success
  end

  test "fridge empty" do
    get :fridge
    assert_response :success
  end

  test "fridge with first level data" do
    get :fridge, ingrediences: [ingrediences(:one).id, ingrediences(:two).id]
    assigns(:recipes)
    assert_response :success
  end

  test "fridge with second level data" do
    get :fridge, ingrediences: [
      ingrediences(:one).id.to_s + "|1",
      ingrediences(:two).id.to_s + "|1"
    ]
    assigns(:recipes)
    assert_response :success
  end

  test "filter empty" do
    get :filter
    assert_response :success
  end

  test "filter with data" do
    get :filter, filter: {
      :text => "rec",
      :text_type => 1,
      :level => 0,
      :time_min => 0,
      :time_max => 1000
    }
    assigns(:recipes)
    assert_response :success
  end

  test "newest" do
    get :newest
    assert_response :success
  end
end
