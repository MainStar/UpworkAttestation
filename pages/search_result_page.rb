require_relative '../base/base_page'

class SearchResultPage < BasePage

  FREELANCER_NAME_FORMAT = '//section[@data-qa="freelancer"][%s]//div[contains(@class,"ellipsis")]//h4/a'
  FREELANCER_TITLE_FORMAT = '//section[@data-qa="freelancer"][%s]//h4[contains(@class,"freelancer-tile-title")]'
  FREELANCER_DESCRIPTION_FORMAT = '//section[@data-qa="freelancer"][%s]//div[contains(@class,"d-lg-block")]//p'
  FREELANCER_SKILLS_FORMAT = '//section//section[@data-compose-log-data][%s]//div[@class="skills-section"]//span'
  FREELANCER_EXTRA_SKILLS_FORMAT = '//section//section[@data-compose-log-data][%s]//a[contains(@title,"more")]/parent::*/span[@class="d-none"]'

  SEARCH_RESULT_SECTION = 'section[data-qa="freelancer"]'

  # WAIT section =====================================================

  # This function wait for search result region to be present
  def wait_for_search_result_section_to_load
    wait_for_element_present(SEARCH_RESULT_SECTION)
  end

  # Wait section =====================================================

  # This function click to Freelancer name by number
  #
  # @input @number - freelancer number from `Search Page`
  def click_to_freelancer_name_by_number(number)
    click('Click to Freelancer name by number', @driver.find_element(:xpath, FREELANCER_NAME_FORMAT % [number]))
    ProfilePage.new(@driver)
  end

  # GET section ======================================================

  # This function returns number of found elements
  def get_search_result_number
    @driver.find_elements(css: SEARCH_RESULT_SECTION).size
  end

  # This function returns Freelancer name by number
  #
  # # @input @number - freelancer number from `Search Page`
  def get_freelancer_name_by_number(number)
    get_element_text("Get freelancer name by number", @driver.find_element(:xpath, FREELANCER_NAME_FORMAT % [number.to_s]))
  end

  # This function returns Freelancer title by number
  #
  # # @input @number - freelancer number from `Search Page`
  def get_freelancer_title_by_number(number)
    get_element_text('Get freelancer title by number', @driver.find_element(:xpath, FREELANCER_TITLE_FORMAT % [number.to_s]))
  end

  # This function returns Freelancer description by number
  #
  # @input @number - freelancer number from `Search Page`
  def get_freelancer_description_by_number(number)
    get_element_text('Get freelancer description by number', @driver.find_element(:xpath, FREELANCER_DESCRIPTION_FORMAT % [number.to_s]))
  end

  # This function returns freelancer skills bu number
  #
  # @input @number - freelancer number from `Search Page`
  def get_freelancer_skills_by_number(number)
    if (displayed?('xpath', FREELANCER_EXTRA_SKILLS_FORMAT % [number.to_s]))
      additional_skills = get_element_text('Get text from additional Skills', @driver.find_element(:xpath, FREELANCER_EXTRA_SKILLS_FORMAT % [number.to_s])).delete("\n").strip.split(',')
      get_elements_text(@driver.find_elements(:xpath, FREELANCER_SKILLS_FORMAT % [number.to_s])).push(*additional_skills).each(&:strip!)
    else
      get_elements_text(@driver.find_elements(:xpath, FREELANCER_SKILLS_FORMAT % [number.to_s])).each(&:strip!)
    end
  end

end