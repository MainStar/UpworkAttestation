require 'selenium-webdriver'

require_relative '../base/base_test'
require_relative '../models/freelancer_profile'
require_relative '../actions/main_actions'
require_relative '../actions/search_actions'
require_relative '../actions/profile_actions'
require_relative '../pages/profile_page'

class SearchTest < BaseTest

  Logger.message('Step 1: Run browser')
  main_actions = MainActions.new

  Logger.message('Step 2: Clear cookies')
  main_actions.clear_all_cookies

  Logger.message('Step 3: Go to www.upwork.com')
  main_actions.open_main_page

  Logger.message('Step 4: Focus onto `Find freelancers`')
  main_actions.change_search_category("Freelancers")

  Logger.message('Step 5: Enter <keyword> into the search input right from the dropdown and submit it (click on the magnifying glass button)')
  search_actions = main_actions.search(Constants::KEYWORD)

  Logger.message('Step 6: Parse the 1st page with search results')
  freelancer_profiles = search_actions.get_search_result

  Logger.message('Step 7: Make sure at least one attribute (title, overview, skills, etc) of each item (found freelancer) from parsed search results contains <keyword>')
  freelancer_profiles.each do |profile|
    profile.attr_check(Constants::KEYWORD)
  end

  Logger.message('Step 8 & 9: Click on random freelancer`s title, Get into that freelancer`s profile')
  rnd_freelancer = rand(1..freelancer_profiles.size)

  Logger.message('Get into that freelancer`s profile')
  profile_page = search_actions.open_freelancer_profile_by_number(rnd_freelancer)

  Logger.message('Step 10: Check that each attribute value is equal to one of those stored in the structure created in #67')
  profile_actions = ProfileActions.new(profile_page)
  profile_actions.profile_attribute_check(freelancer_profiles[rnd_freelancer - 1])

  Logger.message('Step 11: Check whether at least one attribute contains <keyword>')
  profile_actions.attribute_check(Constants::KEYWORD)

end