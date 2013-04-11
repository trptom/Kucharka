require "selenium-webdriver"
gem "test-unit"
require "test/unit"

class 2 < Test::Unit::TestCase

  def setup
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "http://localhost:3000/recipes/new"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end
  
  def teardown
    @driver.quit
    assert_equal [], @verification_errors
  end
  
  def test_2
    @driver.get(@base_url + "/")
    @driver.find_element(:css, "button.btn").click
    @driver.find_element(:name, "commit").click
    # Warning: verifyTextPresent may require manual changes
    verify { assert_match /^[\s\S]*Přihlašování selhalo\. [\s\S]*$/, @driver.find_element(:css, "BODY").text }
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
