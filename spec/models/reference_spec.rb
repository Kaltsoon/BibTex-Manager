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

  it "available attributes are correct for all types" do
    Reference.get_available_types.each do |type|
      reference = Reference.new(name: "#{type}_name", ref_type: type)
      atributes = reference.get_available_attributes()
      should_attributes = "#{type.downcase.capitalize}Reference".constantize.get_available_attributes
      expect(atributes).to be == should_attributes
    end
  end

  it "required attributes are correct for all types" do
    Reference.get_available_types.each do |type|
      reference = Reference.new(name: "#{type}_name", ref_type: type)
      atributes = reference.get_required_attributes()
      should_attributes = "#{type.downcase.capitalize}Reference".constantize.get_required_attributes
      expect(atributes).to be == should_attributes
    end
  end

  it "book reference is saved if name and required attributes set" do

      reference = Reference.new(name: "book", ref_type: "book")
      reference.reference_attributes = [FactoryGirl.create(:reference_attribute, name:"author"), 
      FactoryGirl.create(:reference_attribute, name:"title"),
      FactoryGirl.create(:reference_attribute, name:"publisher"),
      FactoryGirl.create(:reference_attribute, name:"year")] 

    expect(reference).to be_valid
  end

  it "article reference is saved if name and required attributes set" do
      reference = Reference.new(name: "article", ref_type: "article")
      reference.reference_attributes = [FactoryGirl.create(:reference_attribute, name:"author"), 
      FactoryGirl.create(:reference_attribute, name:"title"),
      FactoryGirl.create(:reference_attribute, name:"journal"),
      FactoryGirl.create(:reference_attribute, name:"year")] 

    expect(reference).to be_valid
  end

  it "inproceedings reference is saved if name and required attributes set" do
      reference = Reference.new(name: "inproceedings", ref_type: "inproceedings")
      reference.reference_attributes = [FactoryGirl.create(:reference_attribute, name:"author"), 
      FactoryGirl.create(:reference_attribute, name:"title"),
      FactoryGirl.create(:reference_attribute, name:"booktitle"),
      FactoryGirl.create(:reference_attribute, name:"year")] 

    expect(reference).to be_valid
  end



  it "not set attributes are correct" do
    reference = Reference.new(name: "Kirja", ref_type: "book")
    atributes = reference.get_attributes_not_set()    
    bookAtributes = BookReference.get_available_attributes
    expect(atributes).to be == bookAtributes
  end


end
