require 'spec_helper'

describe ReferenceAttribute do

  it "attribute can be added to a book reference" do
    book_reference = Reference.new(name: "kirja99", ref_type: "book")
    book_reference.reference_attributes = [FactoryGirl.create(:reference_attribute, name:"author"), 
      FactoryGirl.create(:reference_attribute, name:"title"),
      FactoryGirl.create(:reference_attribute, name:"publisher"),
      FactoryGirl.create(:reference_attribute, name:"year")] 

    expect(book_reference.reference_attributes.map{|a| a.name}.include?("edition")).to be(false)
    attribute = ReferenceAttribute.new(name: "edition", value: "test_value")
    book_reference.reference_attributes.push(attribute)
    expect(book_reference.reference_attributes.where(name: "edition").nil?).to eq(false)
  end

  it "attribute can be added to a article reference" do
    article_reference = Reference.new(name: "artikkeli99", ref_type: "article")
    article_reference.reference_attributes = [FactoryGirl.create(:reference_attribute, name:"author"), 
      FactoryGirl.create(:reference_attribute, name:"title"),
      FactoryGirl.create(:reference_attribute, name:"journal"),
      FactoryGirl.create(:reference_attribute, name:"year")]
      
    expect(article_reference.reference_attributes.map{|a| a.name}.include?("month")).to be(false)
    attribute = ReferenceAttribute.new(name: "month", value: "test_value")
    article_reference.reference_attributes.push(attribute)
    expect(article_reference.reference_attributes.where(name: "month").nil?).to eq(false)
  end

  it "attribute can be added to a inproceedings reference" do
    inproceedings_reference = Reference.new(name: "inproceedings99", ref_type: "inproceedings")
    inproceedings_reference.reference_attributes = [FactoryGirl.create(:reference_attribute, name:"author"), 
      FactoryGirl.create(:reference_attribute, name:"title"),
      FactoryGirl.create(:reference_attribute, name:"booktitle"),
      FactoryGirl.create(:reference_attribute, name:"year")]

    expect(inproceedings_reference.reference_attributes.map{|a| a.name}.include?("pages")).to be(false)
    attribute = ReferenceAttribute.new(name: "pages", value: "test_value")
    inproceedings_reference.reference_attributes.push(attribute)
    expect(inproceedings_reference.reference_attributes.where(name: "pages").nil?).to eq(false)
  end
end
