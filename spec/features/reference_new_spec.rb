require 'spec_helper'

include TestHelper

describe "New reference page" do
  
  before :all do
    self.use_transactional_fixtures = false
  end

  before :each do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
    Capybara.session_name = ":session_#{Time.now.to_i}"
    visit new_reference_path
  end

  after :each do
    DatabaseCleaner.clean
  end

  after :all do
    self.use_transactional_fixtures = true
  end

  it "doesn't save reference if name not valid", js:true do
    visit new_reference_path
    fill_in("reference_name", with: "")
    click_button("submit_reference")
    expect(page).to have_content "Name can't be blank"
  end

  it "saves reference if attributes and name are valid", js:true do
    fill_in_attributes("title")
    
    expect(page).to have_content 'Reference was successfully created'
  end
  
end
