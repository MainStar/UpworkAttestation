
require_relative '../pages/profile_page'
require_relative '../models/freelancer_profile'

class ProfileActions
  def initialize(profile_page)
    @profile_page = profile_page
  end

  # This function compare values from profile from `Search Page` and from `Profile Page`
  #
  # @input @profile - Freelance or Company profile
  def profile_attribute_check(profile)

    # Check is freelancer title visible, and check attributes as Freelancer / Else, will check Company's Attributes
    if @profile_page.is_freelancer_title_displayed

      # Getting values from Freelancer's attributes (Name, title, Description)

      @profile_page.wait_for_freelancer_skills_displayed
      freelancer_name = @profile_page.get_freelancer_name_text
      freelancer_title = @profile_page.get_freelancer_title_text
      freelancer_description = @profile_page.get_freelancer_description_text
      freelancer_skills = if @profile_page.is_freelancer_skills_displayed
                            @profile_page.get_freelancer_skills
                          end

      freelancer_profile = FreelancerProfile.new(freelancer_name, freelancer_title, freelancer_description, freelancer_skills)
      check(profile, freelancer_profile)
    else

      # Getting values from Company's attributes (Name, title, Description)

      @profile_page.wait_for_company_skills_displayed
      company_name = @profile_page.get_company_name_text
      company_title = @profile_page.get_company_title_text
      company_description = @profile_page.get_company_description_text
      freelancer_skills = if @profile_page.is_company_skills_displayed
                            @profile_page.get_company_skills
                          end

      freelancer_profile = FreelancerProfile.new(company_name, company_title, company_description, freelancer_skills)
      check(profile, freelancer_profile)
    end
  end

  # This function verify that at least one attribute contains <keyword>
  def attribute_check(keyword)
    @profile_page.wait_for_freelancer_page_visible

    # Check title if contains <keyword>
    if @profile_page.is_freelancer_title_displayed
      @profile_page.get_freelancer_title_text.include?(keyword) ? Logger.message("Title attribute contains <#{keyword}>") : Logger.error("Title attribute NOT contains <#{keyword}>")
    else
      @profile_page.get_company_title_text.include?(keyword) ? Logger.message("Title attribute contains <#{keyword}>") : Logger.error("Title attribute NOT contains <#{keyword}>")
    end

    # Check Description if contains <keyword>
    if @profile_page.is_freelancer_description_displayed
      @profile_page.get_freelancer_description_text.include?(keyword) ? Logger.message("Description attribute contains <#{keyword}>") : Logger.error("Description attribute NOT contains <#{keyword}>")
    else
      @profile_page.get_company_description_text.include?(keyword) ? Logger.message("Description attribute contains <#{keyword}>") : Logger.error("Description attribute NOT contains <#{keyword}>")
    end
  end

  # This function comparing to freelancer profiles (Expected and Actual)
  #
  # @input 1. expected profile attributes
  # @input 2. actual profile attributes
  private def check(profile_expected, profile_actual)
    # Check if Nams are equals
    if profile_actual.name.include?(profile_expected.name)
      Logger.message('Name attribute checked Successfully')
    else
      Logger.error("Name attribute check Failed, \nExpected: #{profile_expected.name}, \nActual: #{profile_actual.name}")
    end

    # Check if Titles are equals
    if profile_actual.title.include?(profile_expected.title)
      Logger.message('Title attribute checked Successfully')
    else
      Logger.error("Title attribute check Failed, \nExpected: #{profile_expected.title}, \nActual: #{profile_actual.title}")
    end

    # Check if Descriptions are equals
    if profile_expected.description.include?('...')
      profile_expected.description.slice!('...')
    end
    if profile_actual.description.include?(profile_expected.description)
      Logger.message('Description attribute checked Successfully')
    else
      Logger.error("Description attribute check Failed, \nExpected: #{profile_expected.description}, \nActual: #{profile_actual.description}")
    end

    # Check if Skills are equals
    check = true

    profile_expected.skills.each do |skill|
      skill.delete("\n")
      if skill.include?(' - ')
        test_arr = []
        test_arr = skill.split(' - ').delete_at(test_arr.size - 1).delete(' ')
        skill.replace(test_arr)
      end
    end

    profile_expected.skills = profile_expected.skills.sort
    profile_actual.skills = profile_actual.skills.sort

    profile_expected.skills.each do |skill|
      check = false unless profile_actual.skills.include?(skill)
    end

    if check
      Logger.message('Skills attributes checked Successfully')
    else
      Logger.error("Skills attribute check failed, \n Expected: #{profile_expected.skills}, \n Actual: #{profile_actual.skills}")
    end
  end

end