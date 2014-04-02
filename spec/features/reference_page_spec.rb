require 'spec_helper'

describe "Reference page" do
    before :all do
    self.use_transactional_fixtures = false

  end

  before :each do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start

  end
  it "doesn't save reference if name not valid", js:true do
    visit new_reference_path
      
      within("#attributes_form"){

        fill_in('attribute_author', with:'au')
        fill_in('attribute_title', with:'ti')
        fill_in('attribute_publisher', with:'pu')
        fill_in('attribute_year', with:'1234')
      }
      save_and_open_page
      click_button("submit_reference") 
    
      expect(page).to have_content 'error prohibited this reference from being saved'
  end

  it "saves reference if attributes and name are valid", js:true do
    visit new_reference_path

      fill_in('reference_name', with:'title1')

      within("#attributes_form"){
        fill_in('attribute_author', with:'au')
        fill_in('attribute_title', with:'ti')
        fill_in('attribute_publisher', with:'pu')
        fill_in('attribute_year', with:'1234')
      }
      click_button("submit_reference") 

      expect(page).to have_content 'Reference was successfully created'
  end

  after :each do
    DatabaseCleaner.clean
  end

  after :all do
    self.use_transactional_fixtures = true
  end
end
