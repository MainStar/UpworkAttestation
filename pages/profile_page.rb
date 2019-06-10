
require_relative '../base/base_page'

class ProfilePage < BasePage

  # Locators ============================================================================

  FREELANCER_NAME = '//div[contains(@class,"air-card")]//div[@class="media"]//h2'
  COMPANY_NAME = '//div[@class="row"]//div[@class="media"]//h2'

  FREELANCER_TITLE = '//div[@class="overlay-container"]//h3'
  COMPANY_TITLE = '//div[contains(@class,"air-card")]//h3[@ng-if="vm.profile.title"]'
  PROFILE_REGION = '//div[contains(@class,"fe-ui-application")]'

  FREELANCER_DESCRIPTION = '//o-profile-overview[@words=80]//p'
  COMPANY_DESCRIPTION = '//div[contains(@class,"air-card")]//div[@o-text-truncate]'

  FREELANCER_SKILLS = '//div[@data-ng-if="skills.length"]/span/span | //div//span[@data-ng-if="answer"]'
  COMPANY_SKILLS = '//div[contains(@class,"o-profile-skills")]/a'

  # Wait section ====================================================

  # This function wait for Freelancer page to be visible
  def wait_for_freelancer_page_visible
    sleep 15
  end

  # This function wait for Freelancer Skills to Be displayed
  def wait_for_freelancer_skills_displayed
    wait_for_element_present@driver.find_elements(:xpath, FREELANCER_SKILLS)
  end

  # This function wait for Company Skills to bo visible
  def wait_for_company_skills_displayed
    wait_for_element_present@driver.find_elements(:xpath, COMPANY_SKILLS)
  end

  # Is Displayed Section ============================================

  # This function verifying is Freelancer title visible
  def is_freelancer_title_displayed
    @driver.find_element(:xpath, FREELANCER_TITLE).displayed?
  end

  # This function verifying is Company title visible
  def is_company_title_displayed
    @driver.find_element(:xpath, COMPANY_TITLE).displayed?
  end

  # This function verifying is Freelancer description displayed
  def is_freelancer_description_displayed
    @driver.find_element(:xpath, FREELANCER_DESCRIPTION).displayed?
  end

  # This function verifying is Freelancer Skills displayed
  def is_freelancer_skills_displayed
    @driver.find_element(:xpath, FREELANCER_SKILLS).displayed?
  end

  # This function verifying is Company Skills displayed
  def is_company_skills_displayed
    @driver.find_element(:xpath, COMPANY_SKILLS).displayed?
  end

  # Get Text Section ===============================================

  #This function @return a value from Freelancer name
  def get_freelancer_name_text
    get_element_text('Get text from Freelancer name', @driver.find_element(:xpath, FREELANCER_NAME))
  end

  # This function @return a value from Freelancer title
  def get_freelancer_title_text
    get_element_text('Get text from Freelancer title', @driver.find_element(:xpath, FREELANCER_TITLE))
  end

  # This function @return a value from Freelancer description
  def get_freelancer_description_text
    get_element_text('Get text from Freelancer description', @driver.find_element(:xpath, FREELANCER_DESCRIPTION))
  end

  # This function @return a value from Company Name
  def get_company_name_text
    get_element_text('Get text from Company name', @driver.find_element(:xpath, COMPANY_NAME))
  end

  # This function @return a value from Company title
  def get_company_title_text
    get_element_text('Get text from Company title', @driver.find_element(:xpath, COMPANY_TITLE))
  end

  # This function @return a value from Company description
  def get_company_description_text
    get_element_text('Get text from Company description', @driver.find_element(:xpath, COMPANY_DESCRIPTION))
  end

  # This function @return a value from Freelancer skills
  def get_freelancer_skills
    get_elements_text(@driver.find_elements(:xpath, FREELANCER_SKILLS))
  end

  # This function @return a value from Company skills
  def get_company_skills
    get_elements_text(@driver.find_elements(:xpath, COMPANY_SKILLS))
  end

end