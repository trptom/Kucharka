require "selenium-webdriver"
gem "test-unit"
require "test/unit"

class IngredienceZadost < Test::Unit::TestCase

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
  
  def test_ingredience_zadost
    @driver.get(@base_url + "/")
    @driver.find_element(:id, "d2").click
    @driver.find_element(:id, "d1").click
    @driver.find_element(:link, "Moje recepty").click
    @driver.find_element(:link, "Napsat nový recept").click
    @driver.find_element(:id, "new_ingredience_name").clear
    @driver.find_element(:id, "new_ingredience_name").send_keys "Ahoj"
    @driver.find_element(:id, "new_ingredience_units").clear
    @driver.find_element(:id, "new_ingredience_units").send_keys "123"
    @driver.find_element(:css, "div.well > button.btn").click
    assert_equal "Požadavek na přídání ingredience se nepodeřilo odeslat!", close_alert_and_get_its_text()
    @driver.find_element(:id, "new_ingredience_units").clear
    @driver.find_element(:id, "new_ingredience_units").send_keys "kg"
    @driver.find_element(:css, "div.well > button.btn").click
    assert_equal "Požadavek na přídání ingredience se nepodeřilo odeslat!", close_alert_and_get_its_text()
    @driver.find_element(:id, "new_ingredience_annotation").clear
    @driver.find_element(:id, "new_ingredience_annotation").send_keys "Anotace AnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotace"
    @driver.find_element(:id, "new_ingredience_content").clear
    @driver.find_element(:id, "new_ingredience_content").send_keys "Anotace AnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotace AnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotace"
    @driver.find_element(:css, "div.well > button.btn").click
    assert_equal "Požadavek na přídání ingredience se nepodeřilo odeslat!", close_alert_and_get_its_text()
    @driver.find_element(:id, "new_ingredience_content").clear
    @driver.find_element(:id, "new_ingredience_content").send_keys "Anotace AnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceanotace anotace anotace"
    @driver.find_element(:id, "new_ingredience_annotation").clear
    @driver.find_element(:id, "new_ingredience_annotation").send_keys "Anotace AnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnota"
    @driver.find_element(:css, "div.well > button.btn").click
    assert_equal "Požadavek na přídání ingredience se nepodeřilo odeslat!", close_alert_and_get_its_text()
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
