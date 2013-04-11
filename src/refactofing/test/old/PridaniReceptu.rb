require "selenium-webdriver"
require "rspec"
include RSpec::Expectations

describe "PridaniReceptu" do

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
  
  it "test_pridani_receptu" do
    @driver.get(@base_url + "/")
    @driver.find_element(:id, "d2").click
    @driver.find_element(:id, "d1").click
    @driver.find_element(:link, "Moje recepty").click
    @driver.find_element(:link, "Napsat nový recept").click
    @driver.find_element(:name, "commit").click
    # Warning: verifyTextPresent may require manual changes
    verify { @driver.find_element(:css, "BODY").text.should =~ /^[\s\S]*Name špatná délka názvu \(3-50\)[\s\S]*$/ }
    @driver.find_element(:id, "recipe_name").clear
    @driver.find_element(:id, "recipe_name").send_keys "Testovací recept"
    @driver.find_element(:name, "commit").click
    # Warning: verifyTextPresent may require manual changes
    verify { @driver.find_element(:css, "BODY").text.should =~ /^[\s\S]*Annotation špatná délka anotace \(50-255\)[\s\S]*$/ }
    @driver.find_element(:id, "recipe_annotation").clear
    @driver.find_element(:id, "recipe_annotation").send_keys "Anotace AnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotace"
    @driver.find_element(:name, "commit").click
    # Warning: verifyTextPresent may require manual changes
    verify { @driver.find_element(:css, "BODY").text.should =~ /^[\s\S]*Annotation špatná délka anotace \(50-255[\s\S]*$/ }
    @driver.find_element(:id, "recipe_annotation").clear
    @driver.find_element(:id, "recipe_annotation").send_keys "Anotace AnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotace"
    @driver.find_element(:id, "recipe_content").clear
    @driver.find_element(:id, "recipe_content").send_keys "AnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotace"
    @driver.find_element(:id, "recipe_annotation").clear
    @driver.find_element(:id, "recipe_annotation").send_keys ""
    @driver.find_element(:name, "commit").click
    # Warning: verifyTextPresent may require manual changes
    verify { @driver.find_element(:css, "BODY").text.should =~ /^[\s\S]*Annotation špatná délka anotace \(50-255\)[\s\S]*$/ }
    @driver.find_element(:id, "recipe_annotation").clear
    @driver.find_element(:id, "recipe_annotation").send_keys "Anotace AnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotaceAnotace"
    @driver.find_element(:id, "ingredience_quantity").clear
    @driver.find_element(:id, "ingredience_quantity").send_keys "f"
    @driver.find_element(:id, "ingredience_importance").clear
    @driver.find_element(:id, "ingredience_importance").send_keys "f"
    @driver.find_element(:css, "input.btn").click
    (close_alert_and_get_its_text()).should == "Množství není číslo > 0"
    @driver.find_element(:id, "ingredience_quantity").clear
    @driver.find_element(:id, "ingredience_quantity").send_keys "1"
    @driver.find_element(:id, "ingredience_importance").clear
    @driver.find_element(:id, "ingredience_importance").send_keys "1"
    @driver.find_element(:css, "input.btn").click
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "recipe_level")).select_by(:text, "Střední")
    @driver.find_element(:id, "recipe_estimated_time").clear
    @driver.find_element(:id, "recipe_estimated_time").send_keys "dffd"
    @driver.find_element(:name, "commit").click
    # Warning: verifyTextPresent may require manual changes
    verify { @driver.find_element(:css, "BODY").text.should =~ /^[\s\S]*Estimated time level není celé číslo > 0[\s\S]*$/ }
    @driver.find_element(:id, "recipe_estimated_time").clear
    @driver.find_element(:id, "recipe_estimated_time").send_keys "30"
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
