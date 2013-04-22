require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  setup do
    login_user users(:admin)
  end

  teardown do
    logout_user
  end

  test "index" do
    get :index
    assert_response :success
  end

  test "search no query" do
    get :search
    assigns :articles
    assigns :recipes
    assert_response :success
  end
  
  test "search simple query" do
    get :search, search_query: "Search result" # mam pripravene vysledky ve fixtures - melo by najit 1 clanek a 1 recept
    @articles = assigns :articles
    @recipes = assigns :recipes
    assert_equal(1, @articles.count)
    assert_equal(1, @recipes.count)

    assert_response :success
  end

  test "search with no results" do
    get :search, search_query: "somestringwhichshouldntbefoundindatabase";
    @articles = assigns :articles
    @recipes = assigns :recipes
    assert_equal(0, @articles.count)
    assert_equal(0, @recipes.count)
    assert_response :success
  end

  test "search with empty string" do
    get :search, search_query: "" # mam pripravene vysledky ve fixtures - melo by najit 1 clanek a 1 recept
    @articles = assigns :articles
    @recipes = assigns :recipes
    assert_equal(0, @articles.count) # nemelo by nejit nic - neplatny vyraz
    assert_equal(0, @recipes.count)

    assert_response :success
  end

  test "error" do
    get :error
    assert_response :success
  end

  test "success" do
    get :success
    assert_response :success
  end
end
