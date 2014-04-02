require "spec_helper"

include BibtexGenerator

describe "BibtexGenerator" do
	it "generator valid bibtex without scandic letters string" do
		reference = Reference.new(name: "Kirja", ref_type: "book")
	    reference.reference_attributes = [FactoryGirl.create(:reference_attribute, name:"author", value: "kalle ilves"), 
	      FactoryGirl.create(:reference_attribute, name:"title", value: "kallen kokkikirja"),
	      FactoryGirl.create(:reference_attribute, name:"publisher", value: "otava"),
	      FactoryGirl.create(:reference_attribute, name:"year", value: "2014")] 
	    expect(generate_bibtex_string([reference])).to eq("@book{Kirja,\nauthor = {kalle ilves}\ntitle = {kallen kokkikirja}\npublisher = {otava}\nyear = {2014}\n}\n")
	end
end