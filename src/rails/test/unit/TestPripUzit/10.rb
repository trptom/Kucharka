require "selenium-webdriver"
gem "test-unit"
require "test/unit"

class 10 < Test::Unit::TestCase

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
  
  def test_10
    @driver.get(@base_url + "/")
    @driver.find_element(:id, "d1").click
    @driver.find_element(:link, "Moje recepty").click
    @driver.find_element(:link, "Napsat nový recept").click
    @driver.find_element(:id, "recipe_name").clear
    @driver.find_element(:id, "recipe_name").send_keys "Testovací recept"
    @driver.find_element(:id, "ingredience_quantity").clear
    @driver.find_element(:id, "ingredience_quantity").send_keys "1"
    @driver.find_element(:id, "ingredience_importance").clear
    @driver.find_element(:id, "ingredience_importance").send_keys "5"
    @driver.find_element(:css, "input.btn").click
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "ingredience_select")).select_by(:text, "mléko (l)")
    @driver.find_element(:css, "input.btn").click
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "ingredience_select")).select_by(:text, "Kuřee (kg)")
    @driver.find_element(:css, "input.btn").click
    @driver.find_element(:id, "recipe_annotation").clear
    @driver.find_element(:id, "recipe_annotation").send_keys "anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace"
    @driver.find_element(:id, "recipe_content").clear
    @driver.find_element(:id, "recipe_content").send_keys "anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace anotace"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "recipe_level")).select_by(:text, "Jednoduchý")
    @driver.find_element(:name, "commit").click
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
