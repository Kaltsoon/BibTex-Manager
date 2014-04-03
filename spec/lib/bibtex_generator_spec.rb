require "spec_helper"

include BibtexGenerator

describe "BibtexGenerator" do
	it "generates valid bibtex string without scandic letters in attributes" do
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
	    
	    expect(generate_bibtex_string([reference1])).to eq("@book{Kirja,\n\tauthor = {kalle ilves},\n\ttitle = {kallen kokkikirja},\n\tpublisher = {otava},\n\tyear = {2014}\n}")
	    expect(generate_bibtex_string([reference2])).to eq("@article{Artikkeli,\n\tauthor = {henri korpela},\n\ttitle = {pullien paiston ABC},\n\tjournal = {keittokirja},\n\tyear = {2014}\n}")
	    expect(generate_bibtex_string([reference3])).to eq("@inproceedings{Joku,\n\tauthor = {henri korpela},\n\ttitle = {Croisantin syonnin taito},\n\tbooktitle = {Croisanttien maailma},\n\tyear = {2014}\n}")
	end
end