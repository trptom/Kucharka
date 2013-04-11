require "selenium-webdriver"
gem "test-unit"
require "test/unit"

class SpravaIngredience < Test::Unit::TestCase

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
  
  def test_sprava_ingredience
    @driver.get(@base_url + "/")
    @driver.find_element(:id, "d1").click
    @driver.find_element(:link, "Moje recepty").click
    @driver.find_element(:link, "Napsat nový recept").click
    @driver.find_element(:id, "new_ingredience_name").clear
    @driver.find_element(:id, "new_ingredience_name").send_keys "Testovacii"
    @driver.find_element(:id, "new_ingredience_units").clear
    @driver.find_element(:id, "new_ingredience_units").send_keys "kg"
    @driver.find_element(:id, "new_ingredience_annotation").clear
    @driver.find_element(:id, "new_ingredience_annotation").send_keys "test testtesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttest"
    @driver.find_element(:id, "new_ingredience_content").clear
    @driver.find_element(:id, "new_ingredience_content").send_keys "testtesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttest"
    @driver.find_element(:css, "div.well > button.btn").click
    assert_equal "Požadavek na přídání ingredience odeslán...", close_alert_and_get_its_text()
    @driver.find_element(:link, "Home").click
    @driver.find_element(:id, "d2").click
    @driver.find_element(:link, "Ingredience").click
    @driver.find_element(:xpath, "(//a[contains(text(),'Zobrazit')])[13]").click
    @driver.find_element(:link, "Editovat").click
    @driver.find_element(:id, "ingredience_activation_state").click
    @driver.find_element(:id, "ingredience_activation_state").click
    @driver.find_element(:id, "ingredience_activation_state").click
    @driver.find_element(:id, "ingredience_avaliability").clear
    @driver.find_element(:id, "ingredience_avaliability").send_keys "š"
    @driver.find_element(:name, "commit").click
    # Warning: verifyTextPresent may require manual changes
    verify { assert_match /^[\s\S]*Avaliability chybná dostupnost \(musí být v rozmezí 1-1000\)[\s\S]*$/, @driver.find_element(:css, "BODY").text }
    @driver.find_element(:id, "ingredience_avaliability").clear
    @driver.find_element(:id, "ingredience_avaliability").send_keys "1"
    @driver.find_element(:id, "ingredience_units").clear
    @driver.find_element(:id, "ingredience_units").send_keys "+"
    @driver.find_element(:name, "commit").click
    @driver.find_element(:id, "d2").click
    @driver.find_element(:link, "Ingredience").click
    @driver.find_element(:xpath, "(//a[contains(text(),'Smazat')])[7]").click
    @driver.find_element(:link, "Smazat").click
    @driver.find_element(:link, "Smazat").click
    @driver.find_element(:id, "d2").click
    @driver.find_element(:link, "Ingredience").click
    @driver.find_element(:xpath, "(//a[contains(text(),'Smazat')])[13]").click
    @driver.find_element(:link, "Smazat").click
    @driver.find_element(:link, "Seznam").click
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
