require "selenium-webdriver"
gem "test-unit"
require "test/unit"

class EditaceUzivatele < Test::Unit::TestCase

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
  
  def test_editace_uzivatele
    @driver.get(@base_url + "/")
    @driver.find_element(:id, "d1").click
    @driver.find_element(:link, "Moje údaje").click
    @driver.find_element(:css, "input.btn").click
    @driver.find_element(:id, "user_first_name").clear
    @driver.find_element(:id, "user_first_name").send_keys "123"
    @driver.find_element(:id, "user_second_name").clear
    @driver.find_element(:id, "user_second_name").send_keys "123"
    @driver.find_element(:name, "commit").click
    # Warning: verifyTextPresent may require manual changes
    verify { assert_match /^[\s\S]*First name chybný formát jména \(alespoň 2 znaky\)[\s\S]*$/, @driver.find_element(:css, "BODY").text }
    # Warning: verifyTextPresent may require manual changes
    verify { assert_match /^[\s\S]*Second name chybný formát příjmení \(alespoň 2 znaky\)[\s\S]*$/, @driver.find_element(:css, "BODY").text }
    @driver.find_element(:id, "user_first_name").clear
    @driver.find_element(:id, "user_first_name").send_keys "admiadmin"
    @driver.find_element(:id, "user_second_name").clear
    @driver.find_element(:id, "user_second_name").send_keys "adminadmin"
    @driver.find_element(:name, "commit").click
    # Warning: verifyTextPresent may require manual changes
    verify { assert_match /^[\s\S]*Detail uživatele[\s\S]*$/, @driver.find_element(:css, "BODY").text }
    @driver.find_element(:css, "input.btn").click
    @driver.find_element(:xpath, "(//input[@id='user_password'])[2]").clear
    @driver.find_element(:xpath, "(//input[@id='user_password'])[2]").send_keys "root"
    @driver.find_element(:id, "user_password_confirmation").clear
    @driver.find_element(:id, "user_password_confirmation").send_keys "root"
    @driver.find_element(:xpath, "(//input[@name='commit'])[2]").click
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
