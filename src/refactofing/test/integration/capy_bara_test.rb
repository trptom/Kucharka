# coding:utf-8

require 'test_helper'

class CapyBaraTest < ActionDispatch::IntegrationTest
  def test_foo
    login nil
    logout
#
#    current = URI.parse(current_url)
#    "#{current.path}?#{current.query}".should == uri
#    assert_uri "/fridge"
  end
end
