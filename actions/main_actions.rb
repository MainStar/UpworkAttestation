require_relative '../base/base_page'
require_relative '../pages/navigation_bar_page'
require_relative '../actions/search_actions'

class MainActions

  def clear_all_cookies
    BaseTest.driver.manage.delete_all_cookies
  end

  def open_main_page
    BasePage.new(BaseTest.driver).navigate_to_url("www.upwork.com")
  end

  def change_search_category(category)
    page = NavigationBarPage.new(BaseTest.driver)
    page.wait_for_search_category_dropdown_visible
    page.click_to_search_category_dropdown
    page.select_category_from_dropdown(category)
  end

  def search(keyword)
    page = NavigationBarPage.new(BaseTest.driver)
    page.type_to_search_field(keyword)
    page.click_to_submit_search_button

    SearchActions.new
  end

end