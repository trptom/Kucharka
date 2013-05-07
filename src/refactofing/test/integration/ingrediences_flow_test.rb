# coding:utf-8

require 'test_helper'

class IngrediencesFlowTest < ActionDispatch::IntegrationTest
  def test_create_edit_and_delete
    login nil

    click_on "d2"
    click_on "Ingredience"
    assert_equal ingrediences_path, current_path
    assert page.has_content? "schválené"
    assert page.has_content? "neschválené"

    click_on "Nová ingredience"
    assert_equal new_ingredience_path, current_path

    fill_in "ingredience[name]", :with => "exampleIngredience"
    fill_in "ingredience[units]", :with => "kg"
    click_on "Nastavit"

    ingredience = Ingredience.find_by_name "exampleIngredience"

    assert_equal ingredience_path(ingredience), current_path

    click_on "d2"
    click_on "Ingredience"

    find(:xpath, "//a[@href='" + edit_ingredience_path(ingredience) + "']").click
    assert_equal edit_ingredience_path(ingredience), current_path

    fill_in "ingredience[name]", :with => "exampleIngredience2"
    click_on "Nastavit"

    assert_equal ingredience_path(ingredience), current_path
    assert page.has_content? "exampleIngredience2"

    click_on "Smazat"
    page.driver.browser.switch_to.alert.accept
    assert_equal ingrediences_path, current_path
    assert !(page.has_content? "exampleIngredience2")

    logout
  end

  def test_not_logged_in
    visit "/ingrediences"
    assert_equal "/ingrediences", current_path

    visit "/ingrediences.json"
    assert_equal "/ingrediences", current_path

    visit edit_ingredience_path(ingrediences(:one))
    assert_equal "/home/error", current_path

    visit new_ingredience_path
    assert_equal "/home/error", current_path
  end

  def test_add_via_request
    login :username => "one", :password => "password"
    user = User.find(users(:one).id)

    click_on "d1"
    click_on "Moje recepty"

    assert page.has_content? user.recipes.first.name
    click_link user.recipes.first.name

    annotation = "
        123456789 123456789 123456789 123456789 123456789
        123456789 123456789 123456789 123456789 123456789"
    content = "
        123456789 123456789 123456789 123456789 123456789
        123456789 123456789 123456789 123456789 123456789
        123456789 123456789 123456789 123456789 123456789
        123456789 123456789 123456789 123456789 123456789
        123456789 123456789 123456789 123456789 123456789"

    fill_in "ingredience_request_name", :with => "requested123456"
    fill_in "ingredience_request_units", :with => "l"
    fill_in "ingredience_request_annotation", :with => annotation
    fill_in "ingredience_request_content", :with => content
    click_on "Podat žádost"

    assert !(page.driver.browser.switch_to.alert.text.include? "chyba")
    page.driver.browser.switch_to.alert.accept

    ingredience = Ingredience.find_by_name "requested123456"
    assert ingredience
    assert_equal "l", ingredience.units
    assert_equal annotation, ingredience.annotation
    assert_equal content, ingredience.content

    logout
  end
end
