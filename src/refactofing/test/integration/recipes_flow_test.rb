# coding:utf-8

require 'test_helper'

class RecipesFlowTest < ActionDispatch::IntegrationTest
  def test_create_and_delete
    login :username => "one", :password => "password"

    click_on "Vytvořit nový recept"
    fill_in "recipe[name]", :with => "Kanec"
    fill_in "recipe[content]", :with => "
      123456789 123456789 123456789 123456789 123456789
      123456789 123456789 123456789 123456789 123456789
      123456789 123456789 123456789 123456789 123456789
      123456789 123456789 123456789 123456789 123456789 
      123456789 123456789 123456789 123456789 123456789 "
    click_on "Vytvořit recept"

    recipe = Recipe.find_all_by_name "Kanec"
    assert_equal recipe_path(recipe), current_path
    assert page.has_content? "Kanec"

    click_on "Upravit recept"

    click_on "d1"
    click_on "Moje recepty"
    assert page.has_content? "Kanec"
    click_on "Kanec"
    assert_equal recipe_path(recipe), current_path

    logout
  end

  def test_not_logged_in
    visit recipe_path(recipes(:one))
    assert_equal recipe_path(recipes(:one)), current_path

    visit new_recipe_path(recipes(:one))
    assert_equal "/home/error", current_path

    visit edit_recipe_path(recipes(:one))
    assert_equal "/home/error", current_path
  end
end
