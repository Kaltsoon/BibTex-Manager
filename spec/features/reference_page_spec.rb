require 'spec_helper'

describe "Reference page" do
  it "uuden luonti ei onnistu jos nimi kentä on tyhjä" do
    visit new_reference_path
      
      within("#book_attributes_form"){

        fill_in('attribute_author', with:'au')
        fill_in('attribute_title', with:'ti')
        fill_in('attribute_publisher', with:'pu')
        fill_in('attribute_year', with:'1234')
      }
      save_and_open_page
      click_button("submit_reference") 
    
      expect(page).to have_content 'error prohibited this reference from being saved'
  end

  it "uuden luonti ei onnistu jos joku atribuutti kentä on tyhjä" do
    visit new_reference_path



      find("#reference_name").set("nimi")
      within("#book_attributes_form"){
        fill_in('attribute_author', with:'au')
        fill_in('attribute_title', with:'ti')
        fill_in('attribute_publisher', with:'pu')
        fill_in('attribute_year', with:'1234')
      }
      find('input[type="submit"]').click

  end


end
