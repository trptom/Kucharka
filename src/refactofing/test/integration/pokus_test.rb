# coding:utf-8

require 'test_helper'

class UserSessionTest < ActionController::IntegrationTest
  fixtures :all
  
  test "login and logout" do
    visit "/"
    click_link "Sign up"
    fill_in "login", :with => users(:admin).username
    fill_in "password", :with => "root"
    clicks_button "Log in"
  end
end
