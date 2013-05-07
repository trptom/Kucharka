# coding:utf-8

require 'test_helper'

class UsersFlowTest < ActionDispatch::IntegrationTest
  # testuje prihlaseni admina, zobrayeni a filtraci seznamu uzivatelu, editaci uzivatele
  def test_admin
    login nil

    # prechod na seynam uzivatelu
    click_on "d2"
    click_on "Uživatelé"
    assert_equal users_path, current_path
    # zobrazeni uzivatele one
    click_link users(:one).username
    assert_equal user_path(users(:one)), current_path
    # editace uzivatele one
    click_link "Editovat"
    assert_equal edit_user_path(users(:one)), current_path
    # vyplneni udaju a overeni zmeny
    fill_in "user[first_name]", :with => "Pokus1"
    fill_in "user[second_name]", :with => "Pokus2"
    click_on "Změnit údaje"
    assert_equal user_path(users(:one)), current_path
    assert_equal "Pokus1", User.find(users(:one).id).first_name
    assert_equal "Pokus2", User.find(users(:one).id).second_name
    # editace uzivatele one (heslo)
    click_link "Editovat"
    assert_equal edit_user_path(users(:one)), current_path
    fill_in "user[old_password]", :with => "password"
    fill_in "user[password]", :with => "password2"
    fill_in "user[password_confirmation]", :with => "password2"
    click_on "Změnit heslo"
    assert_equal user_path(users(:one)), current_path
    click_link "Editovat"
    fill_in "user[old_password]", :with => "password2"
    fill_in "user[password]", :with => "password"
    fill_in "user[password_confirmation]", :with => "password"
    click_on "Změnit heslo"
    assert_equal user_path(users(:one)), current_path

    click_on "d2"
    click_on "Uživatelé"
    assert_equal users_path, current_path
    within("#users-filter") do
      fill_in "filter[username]", :with => "admin"
      click_on "Vyhledat"
    end
    assert_equal users_path, current_path
    click_link users(:admin).username

    logout
  end

  # zkousim jen abych se nedostal nikam, kam nemam
  def test_no_rights
    login :username => "one", :password => "password"

    assert !(find("#d2").has_content?("Uživatelé"))

    visit users_path
    assert_equal "/home/error", current_path

    visit edit_user_path(users(:admin))
    assert_equal "/home/error", current_path

    visit edit_user_path(users(:one))
    assert_equal edit_user_path(users(:one)), current_path

    visit user_path(users(:admin))
    assert_equal user_path(users(:admin)), current_path

    logout
  end

  def test_not_logged_in
    visit "/"

    assert !(page.has_content? users_path)

    visit users_path
    assert_equal "/home/error", current_path

    visit edit_user_path(users(:one))
    assert_equal "/home/error", current_path

    visit user_path(users(:one))
    assert_equal "/home/error", current_path
  end
end
