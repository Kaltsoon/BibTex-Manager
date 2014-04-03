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

  it "add new attributes saved all type reference", js:true do
    Reference.get_available_types.each do |type|
      visit new_reference_path

        fill_in('reference_name', with: "#{type}")

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

        expect(page).to have_content 'Add a new attribute by selecting the attribute name and filling in its value'

        select("volume",:from=> "reference_attribute_name")
        fill_in('reference_attribute_value', with:'1234')
        click_button("Add") 

        expect(page).to have_content "Attribute 'volume' has been set to '1234'"  
      end
  end

  it "should not add new attributes incorrectly all type reference", js:true do
    Reference.get_available_types.each do |type|
      visit new_reference_path

        fill_in('reference_name', with: "#{type}")

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

        expect(page).to have_content 'Add a new attribute by selecting the attribute name and filling in its value'

        select("volume",:from=> "reference_attribute_name")
        fill_in('reference_attribute_value', with:'')
        click_button("Add") 

        expect(page).to have_no_content "Attribute 'volume' has been set to '1234'" 
      end
  end
  after :each do
    DatabaseCleaner.clean
  end

  after :all do
    self.use_transactional_fixtures = true
  end
end
