module TestHelper

  def fill_in_attributes(id)
	fill_in('reference_name', with: id)
     within("#attributes_form"){
      fill_in('attribute_author', with:'au')
      fill_in('attribute_title', with:'ti')
      fill_in('attribute_publisher', with:'pu')
      fill_in('attribute_year', with:'1234')
    }
    click_button("submit_reference")
  end
  
  def create_custom_test_reference(id)
  	reference1 = Reference.new(name: id, ref_type: "book")
    reference1.reference_attributes = [FactoryGirl.create(:reference_attribute, name: "author", value: "A"),
                                       FactoryGirl.create(:reference_attribute, name:"title", value: "A:n Kirja"),
                                       FactoryGirl.create(:reference_attribute, name:"publisher", value: "B"),
                                       FactoryGirl.create(:reference_attribute, name:"year", value: "2014")]
    reference1.save
    visit references_path
  end
  
  def new_attribute_page()
  	click_link("Edit")
    click_link("Attributes")
    click_link("Add a new attribute")
  end
  
  def edit_attribute()
  	click_link("Edit")
    click_link("Attributes")
  end
  
  def remove_attribute()
  	click_link("Edit")
    click_link("Attributes")
    click_link("Remove")
  end
  
  def fill_test_data()
  	reference1 = Reference.new(name: "Kirja", ref_type: "book")
    reference1.reference_attributes = [FactoryGirl.create(:reference_attribute, name: "author", value: "kalle ilves"),
                                       FactoryGirl.create(:reference_attribute, name:"title", value: "kallen kokkikirja"),
                                       FactoryGirl.create(:reference_attribute, name:"publisher", value: "otava"),
                                       FactoryGirl.create(:reference_attribute, name:"year", value: "2014")]
    reference1.save

    reference2 = Reference.new(name: "Artikkeli", ref_type: "article")
    reference2.reference_attributes = [FactoryGirl.create(:reference_attribute, name:"author", value: "henri korpela"),
                                       FactoryGirl.create(:reference_attribute, name:"title", value: "pullien paiston ABC"),
                                       FactoryGirl.create(:reference_attribute, name:"journal", value: "keittokirja"),
                                       FactoryGirl.create(:reference_attribute, name:"year", value: "2014")]
    reference2.save

    reference3 = Reference.new(name: "Joku", ref_type: "inproceedings")
    reference3.reference_attributes = [FactoryGirl.create(:reference_attribute, name:"author", value: "henri korpela"),
                                       FactoryGirl.create(:reference_attribute, name:"title", value: "Croisantin syonnin taito"),
                                       FactoryGirl.create(:reference_attribute, name:"booktitle", value: "Croisanttien maailma"),
                                       FactoryGirl.create(:reference_attribute, name:"year", value: "2014")]
    reference3.save
  end
  
end

RSpec.configure do |config|
  config.include TestHelper, :type => :request
end