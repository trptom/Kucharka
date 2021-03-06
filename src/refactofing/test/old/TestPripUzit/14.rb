require "selenium-webdriver"
gem "test-unit"
require "test/unit"

class 14 < Test::Unit::TestCase

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
  
  def test_14
    @driver.get(@base_url + "/")
    @driver.find_element(:link, "Filtr").click
    @driver.find_element(:name, "filter[text]").clear
    @driver.find_element(:name, "filter[text]").send_keys "Řízek"
    @driver.find_element(:css, "form > button.btn").click
    @driver.find_element(:link, "Dále >>").click
    @driver.find_element(:id, "connected_articles_url").clear
    @driver.find_element(:id, "connected_articles_url").send_keys "http://localhost:3000/articles/5"
    @driver.find_element(:xpath, "//input[@value='Přidat článek']").click
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
