# coding:utf-8

require "selenium-webdriver"
gem "test-unit"
require "test/unit"

class Lednicka < Test::Unit::TestCase

  def setup
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "http://localhost:3000"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end
  
  def teardown
    @driver.quit
    assert_equal [], @verification_errors
  end
  
  def test_lednicka
    @driver.get(@base_url + "/")
    @driver.find_element(:link, "#lednicka").click
    # ERROR: Caught exception [ERROR: Unsupported command [addSelection | id=fridge_select | label=Ahoj1]]
    # ERROR: Caught exception [ERROR: Unsupported command [answerOnNextPrompt | dd | ]]
    @driver.find_element(:id, "fridge_button-add").click
    # ERROR: Caught exception [ERROR: Unsupported command [getPrompt |  | ]]
    # ERROR: Caught exception [ERROR: Unsupported command [answerOnNextPrompt | 1 | ]]
#    assert_equal "Množství \"dd\" není platné celé nebo desetinné číslo!", close_alert_and_get_its_text()
    # ERROR: Caught exception [ERROR: Unsupported command [getPrompt |  | ]]
    # ERROR: Caught exception [ERROR: Unsupported command [addSelection | id=fridge_select | label=Ahoj]]
    # ERROR: Caught exception [ERROR: Unsupported command [removeSelection | id=fridge_select | label=Ahoj1]]
    # ERROR: Caught exception [ERROR: Unsupported command [answerOnNextPrompt | 1 | ]]
    @driver.find_element(:id, "fridge_button-add").click
    # ERROR: Caught exception [ERROR: Unsupported command [getPrompt |  | ]]
    # ERROR: Caught exception [ERROR: Unsupported command [addSelection | id=fridge_selected | label=Ahoj1(1 kg)]]
    @driver.find_element(:id, "fridge_button-remove").click
    @driver.find_element(:id, "fridge_button-submit").click
    # Warning: verifyTextPresent may require manual changes
    verify { assert_match /^[\s\S]*Testovací recept - admin - 2013-01-17 22:32:29 UTC [\s\S]*$/, @driver.find_element(:css, "BODY").text }
    @driver.find_element(:link, "Home").click
  end
  
  def element_present?(how, what)
    @driver.find_element(how, what)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end
  
  def verify(&blk)
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end
  
  def close_alert_and_get_its_text(how, what)
    alert = @driver.switch_to().alert()
    if (@accept_next_alert) then
      alert.accept()
    else
      alert.dismiss()
    end
    alert.text
  ensure
    @accept_next_alert = true
  end
end
