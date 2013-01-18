require "selenium-webdriver"
gem "test-unit"
require "test/unit"

class NovyClanek < Test::Unit::TestCase

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
  
  def test_novy_clanek
    @driver.get(@base_url + "/")
    @driver.find_element(:id, "d1").click
    @driver.find_element(:link, "Moje články").click
    @driver.find_element(:link, "Napsat nový článek").click
    @driver.find_element(:id, "article_title").clear
    @driver.find_element(:id, "article_title").send_keys "ahojahoj"
    @driver.find_element(:id, "article_annotation").clear
    @driver.find_element(:id, "article_annotation").send_keys "ahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahoj"
    @driver.find_element(:name, "commit").click
    # Warning: verifyTextPresent may require manual changes
    verify { assert_match /^[\s\S]*Content špatná délka obsahu \(alespoň 100 znaků\)[\s\S]*$/, @driver.find_element(:css, "BODY").text }
    @driver.find_element(:id, "article_title").clear
    @driver.find_element(:id, "article_title").send_keys ""
    @driver.find_element(:name, "commit").click
    # Warning: verifyTextPresent may require manual changes
    verify { assert_match /^[\s\S]*Title špatná délka titulku \(3-50\)[\s\S]*$/, @driver.find_element(:css, "BODY").text }
    @driver.find_element(:id, "article_title").clear
    @driver.find_element(:id, "article_title").send_keys "ahojahoj"
    @driver.find_element(:id, "article_content").clear
    @driver.find_element(:id, "article_content").send_keys "ahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahojahoj"
    @driver.find_element(:name, "commit").click
    # Warning: verifyTextPresent may require manual changes
    verify { assert_match /^[\s\S]*Article was successfully created\.[\s\S]*$/, @driver.find_element(:css, "BODY").text }
    @driver.find_element(:id, "comment_content").clear
    @driver.find_element(:id, "comment_content").send_keys "ahoj"
    @driver.find_element(:name, "commit").click
    # Warning: verifyTextPresent may require manual changes
    verify { assert_match /^[\s\S]*admin psal [\s\S]*$/, @driver.find_element(:css, "BODY").text }
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
