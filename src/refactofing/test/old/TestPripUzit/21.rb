require "selenium-webdriver"
require "rspec"
include RSpec::Expectations

describe "21" do

  before(:each) do
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "http://localhost:3000/recipes/new"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end
  
  after(:each) do
    @driver.quit
    @verification_errors.should == []
  end
  
  it "test_21" do
    @driver.get(@base_url + "/")
    @driver.find_element(:id, "d2").click
    @driver.find_element(:link, "Ingredience").click
    @driver.find_element(:xpath, "(//a[contains(text(),'Zobrazit')])[13]").click
    @driver.find_element(:link, "Editovat").click
    @driver.find_element(:id, "ingredience_activation_state").click
    @driver.find_element(:name, "commit").click
    @driver.find_element(:link, "Seznam").click
    @driver.find_element(:xpath, "(//a[contains(text(),'Editovat')])[7]").click
    @driver.find_element(:id, "ingredience_activation_state").click
    @driver.find_element(:name, "commit").click
    @driver.find_element(:link, "Seznam").click
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
  rescue ExpectationNotMetError => ex
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
