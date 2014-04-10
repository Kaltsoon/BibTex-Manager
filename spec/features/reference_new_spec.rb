require 'spec_helper'

include TestHelper

describe "New reference page" do
  
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

  it "doesn't save reference if name not valid", js:true do
    fill_in_attributes("")

    expect(page).to have_content "error prohibited this reference from being saved"
  end

  it "saves reference if attributes and name are valid", js:true do
    fill_in_attributes("title")
    
    expect(page).to have_content 'Reference was successfully created'
  end
  
end
