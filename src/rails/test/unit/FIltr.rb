require "selenium-webdriver"
gem "test-unit"
require "test/unit"

class FIltr < Test::Unit::TestCase

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
  
  def test_f_iltr
    @driver.get(@base_url + "/filter?filter%5Btext%5D=&filter%5Btext_type%5D=0&filter%5Blevel%5D=&filter%5Btime_min%5D=&filter%5Btime_max%5D=")
    @driver.find_element(:link, "Filtr").click
    @driver.find_element(:name, "filter[time_min]").clear
    @driver.find_element(:name, "filter[time_min]").send_keys "DE"
    @driver.find_element(:css, "form > button.btn").click
    @driver.get(@base_url + "/")
    @driver.find_element(:link, "Filtr").click
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:name, "filter[level]")).select_by(:text, "Střední")
    @driver.find_element(:css, "form > button.btn").click
    # Warning: verifyTextPresent may require manual changes
    verify { assert_match /^[\s\S]*Kuřecí řízek[\s\S]*$/, @driver.find_element(:css, "BODY").text }
    @driver.find_element(:link, "Home").click
    @driver.find_element(:link, "Filtr").click
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:name, "filter[level]")).select_by(:text, "Killer")
    @driver.find_element(:css, "form > button.btn").click
    @driver.find_element(:link, "Home").click
    @driver.find_element(:link, "Filtr").click
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:name, "filter[level]")).select_by(:text, "Pokročilý")
    @driver.find_element(:css, "form > button.btn").click
    @driver.find_element(:link, "Filtr").click
    @driver.find_element(:name, "filter[text]").clear
    @driver.find_element(:name, "filter[text]").send_keys "řízek"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:name, "filter[level]")).select_by(:text, "obtížnost nespecifikovaná")
    @driver.find_element(:css, "form > button.btn").click
    @driver.find_element(:link, "Home").click
    @driver.find_element(:link, "Filtr").click
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:name, "filter[text_type]")).select_by(:text, "Prohledat titulky a obsah")
    @driver.find_element(:name, "filter[text]").clear
    @driver.find_element(:name, "filter[text]").send_keys "kuřecí"
    @driver.find_element(:css, "form > button.btn").click
    # Warning: verifyTextPresent may require manual changes
    verify { assert_match /^[\s\S]*Kuřecí řízek[\s\S]*$/, @driver.find_element(:css, "BODY").text }
    @driver.find_element(:link, "Filtr").click
    @driver.find_element(:name, "filter[time_min]").clear
    @driver.find_element(:name, "filter[time_min]").send_keys "30"
    @driver.find_element(:name, "filter[time_max]").clear
    @driver.find_element(:name, "filter[time_max]").send_keys "90"
    @driver.find_element(:name, "filter[text]").clear
    @driver.find_element(:name, "filter[text]").send_keys ""
    @driver.find_element(:css, "form > button.btn").click
    # Warning: verifyTextPresent may require manual changes
    verify { assert_match /^[\s\S]*Testovací recept[\s\S]*$/, @driver.find_element(:css, "BODY").text }
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
