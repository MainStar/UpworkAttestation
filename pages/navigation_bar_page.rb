require_relative '../base/base_page'

class NavigationBarPage < BasePage

  # Locators =============================================================================================

  SEARCH_FIELD = '//div[contains(@class,"navbar-collapse d-none")]//input[@name="q"]'
  SEARCH_CATEGORY_BUTTON = '//div[contains(@class,"navbar-collapse d-none")]//button[contains(.,"Switch search source")]'
  DROPDOWN_OPTIONS_FORMAT = '//div[contains(@class,"navbar-collapse d-none")]//a[text()="%s"]'
  SUBMIT_BUTTON = '//div[contains(@class,"navbar-collapse d-none")]//button[contains(.,"Submit search")]'

  # Wait Section ====================================================================================

  # This function wait for search category dropdown to be visible
  def wait_for_search_category_dropdown_visible
    wait_for_element_present(@driver.find_element(:xpath, SEARCH_CATEGORY_BUTTON))
  end

  # Click Section ===================================================================================

  # This function click to category dropdown
  def click_to_search_category_dropdown
    click('Click to categories dropdown', @driver.find_element(:xpath, SEARCH_CATEGORY_BUTTON))
  end

  # This function Choosing category from dropdown
  #
  # @input @category - category name from dropdown
  def select_category_from_dropdown(category)
    click('Click to select category from dropdown', @driver.find_element(:xpath, DROPDOWN_OPTIONS_FORMAT % [category]))
  end

  # This function clicking to submit Search button
  def click_to_submit_search_button
    click('Click to submit search button', @driver.find_element(:xpath, SUBMIT_BUTTON))
  end

  # Type Section =====================================================================================

  # This function type to search field
  #
  # @input @keyword - Keyword to type
  def type_to_search_field(keyword)
    type('Type to `Search` field', keyword, @driver.find_element(:xpath, SEARCH_FIELD))
  end

end