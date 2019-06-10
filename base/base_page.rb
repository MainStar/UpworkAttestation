
# Class describe page with basic action
class BasePage
  def initialize(driver)
    @driver = driver
  end

  def navigate_to_url(url)
    @driver.get(url)
    sleep 2

    @driver
  end

  # This function wait while the element will be visible
  def wait_for_element_present(web_element)
    Selenium::WebDriver::Wait.new(:timeout => 60).until {web_element}
  end

  def wait_until_element_displayed(element, arg = nil)
    if arg.nil?
      Selenium::WebDriver::Wait.new(timeout: timeout).until { displayed?(element, false) }
    else
      Selenium::WebDriver::Wait.new(timeout: timeout).until { displayed?(element, arg) }
    end
  end

  # This function returns true/false dependence if element displayed
  def displayed?(locator_type, web_element)
    begin
      @driver.find_element(locator_type, web_element)
      true
    rescue
      false
    end
  end

  # This function click to web element
  def click(message, web_element)
    Logger.message(message)
    web_element.click
  end

  # This function types string into web element
  def type(message, value, web_element)
    Logger.message(message)
    web_element.clear
    web_element.send_keys(value)
  end

  # This function returns text of define element if element displayed
  def get_element_text(message, web_element)
    Logger.message(message)
    web_element.text
  end

  # This function returns array of texts from web_elements
  #
  # @input web_element
  def get_elements_text(web_elements)
    elements_text = []
    web_elements.each do |element|
      elements_text << element.text
    end
    elements_text
  end

end