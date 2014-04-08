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
    it "edit reference using tooltip ", js:true do
      visit new_reference_path

      fill_in('reference_name', with: "aapinen_tooltip")

      within("#attributes_form"){
        fill_in('attribute_author', with:'au')
        fill_in('attribute_title', with:'ti')
        fill_in('attribute_publisher', with:'pu')
        fill_in('attribute_year', with:'1234')
      }

      click_button("submit_reference") 
      click_link("BibText manager")
      page.find('.reference-attributes-popover').click
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

    it "show reference using tooltip ", js:true do
      visit new_reference_path

      fill_in('reference_name', with: "aapinen_tooltip")

      within("#attributes_form"){
        fill_in('attribute_author', with:'au')
        fill_in('attribute_title', with:'ti')
        fill_in('attribute_publisher', with:'pu')
        fill_in('attribute_year', with:'1234')
      }

      click_button("submit_reference") 
      click_link("BibText manager")
      page.find('.reference-attributes-popover').click
      click_link("Show")

      expect(page).to have_content "aapinen_tooltip book"  
  end

    it "show reference bibtex using tooltip ", js:true do
      visit new_reference_path

      fill_in('reference_name', with: "aapinen_tooltip")

      within("#attributes_form"){
        fill_in('attribute_author', with:'au')
        fill_in('attribute_title', with:'ti')
        fill_in('attribute_publisher', with:'pu')
        fill_in('attribute_year', with:'1234')
      }

      click_button("submit_reference") 
      click_link("BibText manager")
      page.find('.reference-bibtex-popover').click
      
      expect(page).to have_content "@book{aapinen_tooltip, author = {au}, title = {ti}, publisher = {pu}, year = {1234} }"  
  end

    it "edit reference name using tooltip edit", js:true do
      visit new_reference_path

      fill_in('reference_name', with: "edit_aapinen_tooltip")

      within("#attributes_form"){
        fill_in('attribute_author', with:'au')
        fill_in('attribute_title', with:'ti')
        fill_in('attribute_publisher', with:'pu')
        fill_in('attribute_year', with:'1234')
      }

      click_button("submit_reference") 
      click_link("BibText manager")
      page.find('.reference-attributes-popover').click
      click_link("Edit")

      fill_in('reference_name', with: "aapinen_tooltip_edit")
      click_button("Save")

      
      expect(page).to have_content "Reference id has been set to 'aapinen_tooltip_edit'"
      click_link("BibText manager")
      expect(page).to have_content "aapinen_tooltip_edit"

  end

  it "add not valid attribute", js:true do
      visit new_reference_path

      fill_in('reference_name', with: "aapinen_attribute")

      within("#attributes_form"){
        fill_in('attribute_author', with:'au')
        fill_in('attribute_title', with:'ti')
        fill_in('attribute_publisher', with:'pu')
        fill_in('attribute_year', with:'1234')
      }

      click_button("submit_reference") 
      click_link("BibText manager")
      page.find('.reference-attributes-popover').click
      click_link("Edit")
      click_link("Attributes")
      click_link("Add a new attribute")

      within(".panel-body"){
        select("volume", from: "reference_attribute_name")
        fill_in('reference_attribute_value', with:'')
        click_button("Add") 
      }

      expect(page).to have_content "Attribute 'volume' was invalid!"  
  end

  it "destroy attribute", js:true do
      visit new_reference_path

      fill_in('reference_name', with: "aapinen_attribute1")

      within("#attributes_form"){
        fill_in('attribute_author', with:'au')
        fill_in('attribute_title', with:'ti')
        fill_in('attribute_publisher', with:'pu')
        fill_in('attribute_year', with:'1234')
      }

      click_button("submit_reference")

      click_link("BibText manager")
      page.find('.reference-attributes-popover').click
      click_link("Edit")
      click_link("Attributes")
      click_link("Add a new attribute")

      within(".panel-body"){
        select("volume", from: "reference_attribute_name")
        fill_in('reference_attribute_value', with:'123')
        click_button("Add") 
      }

      click_link("BibText manager")
      page.find('.reference-attributes-popover').click
      click_link("Edit")
      click_link("Attributes")
      click_link("Remove")
      page.driver.browser.switch_to.alert.accept


      expect(page).to have_content "Attribute 'volume' has been removed"  
  end
    it "edit attribute", js:true do
      visit new_reference_path

      fill_in('reference_name', with: "attribute_edit")

      within("#attributes_form"){
        fill_in('attribute_author', with:'au')
        fill_in('attribute_title', with:'ti')
        fill_in('attribute_publisher', with:'pu')
        fill_in('attribute_year', with:'1234')
      }

      click_button("submit_reference")

      click_link("BibText manager")
      page.find('.reference-attributes-popover').click
      click_link("Edit")
      click_link("Attributes")
      select("title", from: "reference_attribute_value")
      fill_in('reference_attribute_value', with: "11")
      
      
      expect(page).to have_content Attribute "'volume' has been set to '11'" 
  end
end
