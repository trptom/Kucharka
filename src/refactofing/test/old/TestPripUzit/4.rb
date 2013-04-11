#encoding: utf-8 require "test/unit"
require "rubygems"
gem "selenium-client"
require "selenium/client"

class 4 < Test::Unit::TestCase

  def setup
    @verification_errors = []
    @selenium = Selenium::Client::Driver.new \
      :host => "localhost",
      :port => 4444,
      :browser => "*chrome",
      :url => "http://localhost:3000/recipes/new",
      :timeout_in_second => 60

    @selenium.start_new_browser_session
  end
  
  def teardown
    @selenium.close_current_browser_session
    assert_equal [], @verification_errors
  end
  
  def test_4
    @selenium.open "/home/error"
    @selenium.click "css=button.btn"
    @selenium.type "id=username", "admin"
    @selenium.type "id=password", "root"
    @selenium.click "name=commit"
    @selenium.wait_for_page_to_load "30000"
    begin
        assert @selenium.is_text_present("Vítejte")
    rescue Test::Unit::AssertionFailedError
        @verification_errors << $!
    end
  end
end
