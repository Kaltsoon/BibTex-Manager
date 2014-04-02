require 'spec_helper'

describe Reference do
  it "is not saved if name not set" do
  	reference = Reference.new(name: "", ref_type: "book")
  	expect(reference).to be_invalid
  end

  it "is saved if name set" do
  	reference = Reference.new(name: "Kirja", ref_type: "book")
    reference.reference_attributes = [FactoryGirl.create(:reference_attribute, name:"author"), 
      FactoryGirl.create(:reference_attribute, name:"title"),
      FactoryGirl.create(:reference_attribute, name:"publisher"),
      FactoryGirl.create(:reference_attribute, name:"year")] 

  	expect(reference).to be_valid
  end

  it "atributes ok" do
    reference = Reference.new(name: "Kirja", ref_type: "book")
    atributes = reference.get_available_attributes()
    bookAtributes = BookReference.get_available_attributes
    expect(atributes).to be == bookAtributes
  end

  it "not set atributes ok" do
    reference = Reference.new(name: "Kirja", ref_type: "book")
    atributes = reference.get_attributes_not_set()    
    bookAtributes = BookReference.get_available_attributes
    expect(atributes).to be == bookAtributes
  end

  it "has required attribute ok" do
    reference = Reference.new(name: "Kirja", ref_type: "book")
    
  end

end
