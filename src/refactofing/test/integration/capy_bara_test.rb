# coding:utf-8

require 'test_helper'

class CapyBaraTest < ActionDispatch::IntegrationTest
  def test_foo
    visit '/'
    click_on "Lednička"
    click_on "fridge_button-add"
    click_on "fridge_button-remove"
    click_on "fridge_button-submit"

    assert_equal "/fridge", path
  end
end
