require 'spec_helper'

include TestHelper

describe "Edit reference page" do
  
  before :all do
    self.use_transactional_fixtures = false
  end

  before :each do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
    visit new_reference_path
  end

  after :each do
    DatabaseCleaner.clean
  end

  after :all do
    self.use_transactional_fixtures = true
  end
  
  #Tests
  
  it "reference remove", js:true do
      create_custom_test_reference("reference_remove")

      page.find('.reference-attributes-popover').click
      click_link("Show")

      click_link("Remove")
      page.driver.browser.switch_to.alert.accept

      expect(page).to have_content "Reference 'reference_remove' has been removed" 
  end
  
end