
require_relative '../pages/search_result_page'
require_relative '../models/freelancer_profile'

class SearchActions

  def get_search_result
    i = 1
    freelancer_profiles = []
    page = SearchResultPage.new(BaseTest.driver)
    page.wait_for_search_result_section_to_load
    sleep 10
    while i < page.get_search_result_number + 1
      freelancer_name = page.get_freelancer_name_by_number(i)
      freelancer_title = page.get_freelancer_title_by_number(i)
      freelancer_description = page.get_freelancer_description_by_number(i)
      freelancer_skills = page.get_freelancer_skills_by_number(i)

      freelancer_profiles << FreelancerProfile.new(freelancer_name, freelancer_title, freelancer_description, freelancer_skills)

      i +=1
    end
    freelancer_profiles
  end

  def open_freelancer_profile_by_number(number)
    page = SearchResultPage.new(BaseTest.driver)
    freelancer_profile_page = page.click_to_freelancer_name_by_number(number)
    freelancer_profile_page.wait_for_freelancer_page_visible
    freelancer_profile_page
  end

end