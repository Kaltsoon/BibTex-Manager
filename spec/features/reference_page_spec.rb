require 'spec_helper'

describe "Reference page" do
  
  before :all do
    self.use_transactional_fixtures = false
  end

  before :each do

    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
  end

  after :each do
    DatabaseCleaner.clean
  end

  after :all do
    self.use_transactional_fixtures = true
  end

  it "doesn't save reference if name not valid", js:true do
    visit new_reference_path

    within("#attributes_form"){
      fill_in('attribute_author', with:'au')
      fill_in('attribute_title', with:'ti')
      fill_in('attribute_publisher', with:'pu')
      fill_in('attribute_year', with:'1234')
    }

    click_button("submit_reference")

    expect(page).to have_content "error prohibited this reference from being saved"
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

  it "add a new attributes for the reference", js:true do
      visit new_reference_path

      fill_in('reference_name', with: "aapinen66")

      within("#attributes_form"){
        fill_in('attribute_author', with:'au')
        fill_in('attribute_title', with:'ti')
        fill_in('attribute_publisher', with:'pu')
        fill_in('attribute_year', with:'1234')
      }

      click_button("submit_reference") 
      click_link("Edit")
      click_link("Attributes")
      click_link("Add a new attribute")

      within(".panel-body"){
        select("volume", from: "reference_attribute_name")
        fill_in('reference_attribute_value', with:'1234')
        click_button("Add") 
      }

      expect(page).to have_content "Attribute 'volume' has been set to '1234'"  
  end

end
