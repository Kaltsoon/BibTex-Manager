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
  
  it "edit reference using tooltip ", js:true do
      create_custom_test_reference("aapinen_tooltip")

      page.find('.reference-attributes-popover').click
      new_attribute_page

      within(".panel-body"){
        select("volume", from: "reference_attribute_name")
        fill_in('reference_attribute_value', with:'1234')
        click_button("Add") 
      }

      expect(page).to have_content "Attribute 'volume' has been set to '1234'"  
  end
  
  it "add a new attributes for the reference", js:true do
      fill_in_attributes("aapinen66")

      new_attribute_page

      within(".panel-body"){
        select("volume", from: "reference_attribute_name")
        fill_in('reference_attribute_value', with:'1234')
        click_button("Add") 
      }

      expect(page).to have_content "Attribute 'volume' has been set to '1234'"  
  end
  
  it "add not valid attribute", js:true do
      create_custom_test_reference("aapinen_attribute")

      page.find('.reference-attributes-popover').click
      new_attribute_page

      within(".panel-body"){
        select("volume", from: "reference_attribute_name")
        fill_in('reference_attribute_value', with:'')
        click_button("Add") 
      }

      expect(page).to have_content "Attribute 'volume' was invalid!"  
  end

  it "destroy attribute", js:true do
      create_custom_test_reference("aapinen_attribute1")


      find('.reference-attributes-popover').click
      new_attribute_page

      within(".panel-body"){
        select("volume", from: "reference_attribute_name")
        fill_in('reference_attribute_value', with:'123')
        click_button("Add") 
      }

      visit references_path
      find('.reference-attributes-popover').click
      remove_attribute
      page.driver.browser.switch_to.alert.accept

      expect(page).to have_content "Attribute 'volume' has been removed"  
  end
  
  it "edit attribute", js:true do
      create_custom_test_reference("attribute_edit")

      page.find('.reference-attributes-popover').click
      edit_attribute
      
      find(".reference_attribute_author td input#reference_attribute_value").set("11")
      within(".reference_attribute_author"){
        click_button("Save")
      }
      
      expect(page).to have_content "Attribute 'author' has been set to '11'" 
  end
  
  it "edit attribute set null", js:true do
      create_custom_test_reference("attribute_edit")

      page.find('.reference-attributes-popover').click
      edit_attribute
      find(".reference_attribute_author td input#reference_attribute_value").set("")
      within(".reference_attribute_author"){
        click_button("Save")
      }
      
      expect(page).to have_content "Attribute 'author' was invalid!" 
  end

  it "can't remove requiret attributes" do
    create_custom_test_reference("attribute_remove")
    page.driver.delete("reference_attributes/1")

    expect(page).to have_content "You are being redirected."
  end

  it "Reference attribute not found or reference attribute has been removed", js:true do
    create_custom_test_reference("remove_attribute")

    find('.reference-attributes-popover').click
    new_attribute_page

    within(".panel-body"){
      select("volume", from: "reference_attribute_name")
      fill_in('reference_attribute_value', with:'123')
      click_button("Add") 
    }
    visit references_path
    find('.reference-attributes-popover').click
    
    click_link("Edit")
    click_link("Attributes")
    ReferenceAttribute.last.destroy
    click_link("Remove")
    expect(page).to have_content "Reference attribute not found or reference attribute has been removed"
  end


end