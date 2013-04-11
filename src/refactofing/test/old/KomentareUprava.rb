require "selenium-webdriver"
gem "test-unit"
require "test/unit"

class KomentareUprava < Test::Unit::TestCase

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
  
  def test_komentare_uprava
    @driver.get(@base_url + "/")
    @driver.find_element(:link, "Zobrazit recept").click
    @driver.find_element(:id, "comment_content").clear
    @driver.find_element(:id, "comment_content").send_keys "ksdhkhdsdhsdhshdshdshdkshdkshkdshdshdskdhkshakdskhaskdhsd"
    @driver.find_element(:name, "commit").click
    @driver.find_element(:name, "commit").click
    @driver.find_element(:name, "commit").click
    @driver.find_element(:id, "comment_content").clear
    @driver.find_element(:id, "comment_content").send_keys "ksdhkhdsdhsdhshdshdshdkshdkshkdshdshdskdhkshakdskhaskdhsd ksdhkhdsdhsdhshdshdshdkshdkshkdshdshdskdhkshakdskhaskdhsd ksdhkhdsdhsdhshdshdshdkshdkshkdshdshdskdhkshakdskhaskdhsd ksdhkhdsdhsdhshdshdshdkshdkshkdshdshdskdhkshakdskhaskdhsd ksdhkhdsdhsdhshdshdshdkshdkshkdshdshdskdhkshakdskhaskdhsd ksdhkhdsdhsdhshdshdshdkshdkshkdshdshdskdhkshakdskhaskdhsd ksdhkhdsdhsdhshdshdshdkshdkshkdshdshdskdhkshakdskhaskdhsd ksdhkhdsdhsdhshdshdshdkshdkshkdshdshdskdhkshakdskhaskdhsd ksdhkhdsdhsdhshdshdshdkshdkshkdshdshdskdhkshakdskhaskdhsd ksdhkhdsdhsdhshdshdshdkshdkshkdshdshdskdhkshakdskhaskdhsd ksdhkhdsdhsdhshdshdshdkshdkshkdshdshdskdhkshakdskhaskdhsd ksdhkhdsdhsdhshdshdshdkshdkshkdshdshdskdhkshakdskhaskdhsd ksdhkhdsdhsdhshdshdshdkshdkshkdshdshdskdhkshakdskhaskdhsd ksdhkhdsdhsdhshdshdshdkshdkshkdshdshdskdhkshakdskhaskdhsd ksdhkhdsdhsdhshdshdshdkshdkshkdshdshdskdhkshakdskhaskdhsd ksdhkhdsdhsdhshdshdshdkshdkshkdshdshdskdhkshakdskhaskdhsd ksdhkhdsdhsdhshdshdshdkshdkshkdshdshdskdhkshakdskhaskdhsd ksdhkhdsdhsdhshdshdshdkshdkshkdshdshdskdhkshakdskhaskdhsd ksdhkhdsdhsdhshdshdshdkshdkshkdshdshdskdhkshakdskhaskdhsd ksdhkhdsdhsdhshdshdshdkshdkshkdshdshdskdhkshakdskhaskdhsd ksdhkhdsdhsdhshdshdshdkshdkshkdshdshdskdhkshakdskhaskdhsd ksdhkhdsdhsdhshdshdshdkshdkshkdshdshdskdhkshakdskhaskdhsd ksdhkhdsdhsdhshdshdshdkshdkshkdshdshdskdhkshakdskhaskdhsd ksdhkhdsdhsdhshdshdshdkshdkshkdshdshdskdhkshakdskhaskdhsd ksdhkhdsdhsdhshdshdshdkshdkshkdshdshdskdhkshakdskhaskdhsd ksdhkhdsdhsdhshdshdshdkshdkshkdshdshdskdhkshakdskhaskdhsd ksdhkhdsdhsdhshdshdshdkshdkshkdshdshdskdhkshakdskhaskdhsd ksdhkhdsdhsdhshdshdshdkshdkshkdshdshdskdhkshakdskhaskdhsd ksdhkhdsdhsdhshdshdshdkshdkshkdshdshdskdhkshakdskhaskdhsd"
    @driver.find_element(:name, "commit").click
    @driver.find_element(:css, "#star5 > i.icon-star").click
    @driver.find_element(:id, "connected_articles_url").clear
    @driver.find_element(:id, "connected_articles_url").send_keys "http://localhost:3000/recipes/14"
    @driver.find_element(:xpath, "//input[@value='Přidat článek']").click
    assert_equal "Chyba při přidávání článku (AJAX)!", close_alert_and_get_its_text()
    @driver.find_element(:id, "connected_articles_url").clear
    @driver.find_element(:id, "connected_articles_url").send_keys "recipes/14"
    @driver.find_element(:xpath, "//input[@value='Přidat článek']").click
    assert_equal "Chyba při přidávání článku (AJAX)!", close_alert_and_get_its_text()
    @driver.find_element(:id, "connected_articles_url").clear
    @driver.find_element(:id, "connected_articles_url").send_keys "14"
    @driver.find_element(:xpath, "//input[@value='Přidat článek']").click
    @driver.find_element(:css, "span.newtab-thumbnail").click
    @driver.find_element(:id, "connected_articles_url").clear
    @driver.find_element(:id, "connected_articles_url").send_keys "https://www.google.cz/"
    @driver.find_element(:xpath, "//input[@value='Přidat článek']").click
    assert_equal "Chyba při přidávání článku (AJAX)!", close_alert_and_get_its_text()
    @driver.find_element(:link, "Home").click
    assert_equal "Chyba při přidávání článku (AJAX)!", close_alert_and_get_its_text()
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
