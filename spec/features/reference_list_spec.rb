require 'spec_helper'

include TestHelper

describe "List references page" do
  
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
  
  it "show reference using tooltip ", js:true do
      create_custom_test_reference("aapinen_tooltip")

      page.find('.reference-attributes-popover').click
      click_link("Show")

      expect(page).to have_content "aapinen_tooltip book"  
  end

  it "show reference bibtex using tooltip ", js:true do
      create_custom_test_reference("aapinen_tooltip")

      page.find('.reference-bibtex-popover').click
      
      expect(page).to have_content "@book{aapinen_tooltip, author = {A}, title = {A:n Kirja}, publisher = {B}, year = {2014} }"  
  end
  
  it "edit reference name using tooltip edit", js:true do
      create_custom_test_reference("edit_aapinen_tooltip")

      page.find('.reference-attributes-popover').click
      click_link("Edit")

      fill_in('reference_name', with: "aapinen_tooltip_edit")
      click_button("Save")
  
      expect(page).to have_content "Reference id has been set to 'aapinen_tooltip_edit'"
      click_link("BibText manager")
      expect(page).to have_content "aapinen_tooltip_edit"

  end

  it "edit reference name using tooltip edit", js:true do
      create_custom_test_reference("edit_aapinen_tooltip")

      page.find('.reference-attributes-popover').click
      click_link("Edit")

      fill_in('reference_name', with: "")
      click_button("Save")

      expect(page).to have_content "Name can't be blank"
  end
  
  it "reference download", js:true do
      create_custom_test_reference("reference_download")

      expect(page).to have_content "Download reference"
      click_link("Download reference")
  end
  
  it "View plain BibTex", js:true do
      create_custom_test_reference("reference_view")

      click_link("View plain BibTex")
      expect(page).to have_content "@book{reference_view, author = {A}, title = {A:n Kirja}, publisher = {B}, year = {2014} }"
  end
  
  it "Filttering filters with name", js:true do
  	fill_test_data
  	visit references_path
	click_link("Options")
	fill_in("filter-keyword", with: "Artikkeli")
	expect(page).to have_no_content "Kirja"
	expect(page).to have_no_content "Joku"
	expect(page).to have_content "Artikkeli"
  end
  
  it "Filttering filters with type", js:true do
	fill_test_data
	visit references_path
	click_link("Options")
	fill_in("filter-keyword", with: "article")
	expect(page).to have_no_content "Kirja"
	expect(page).to have_no_content "Joku"
	expect(page).to have_content "Artikkeli"
  end
  
  it "Filttering filters with attribute value", js:true do
	fill_test_data
	visit references_path
	click_link("Options")
	fill_in("filter-keyword", with: "pullien paiston ABC")
	expect(page).to have_no_content "Kirja"
	expect(page).to have_no_content "Joku"
	expect(page).to have_content "Artikkeli"
  end
  
end