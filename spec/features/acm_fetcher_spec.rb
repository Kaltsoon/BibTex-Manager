require 'spec_helper'

include TestHelper

describe "Acm fetcher test" do
  
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

  it "get reference acm ", js:true do
    click_link("Fetch references from ACM")
    fill_in("url", with:"http://dl.acm.org/citation.cfm?id=2380613")
    click_button("Fetch references")
    expect(page).to have_content "Select the references you want to save"
  end

  it "get reference acm url is null", js:true do
    click_link("Fetch references from ACM")
    fill_in("url", with:"")
    click_button("Fetch references")
    expect(page).to have_content "No references found from the given url"
  end

end