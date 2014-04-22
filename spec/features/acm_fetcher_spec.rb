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

  it "get references from acm ", js:true do
    click_link("Fetch references from ACM")
    fill_in("url", with:"http://dl.acm.org/citation.cfm?id=2380613")
    click_button("Fetch references")
    expect(page).to have_content "2012"
    expect(page).to have_content "inproceedings"
  end

end