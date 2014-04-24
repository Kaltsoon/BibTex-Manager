
require "spec_helper"

include IdGenerator

describe "id generator tests" do
	
	it "Database only contains only references with generated names" do
		generate_data_with_generated_names
		attributes = {name: "nimi", author: "test", year: "2014"}
		expect(IdGenerator.generate_id(attributes)).to eq("Tes2014ze")
	end
	
	it "Database contains also user defined names" do
		generate_data_with_generated_names
		generate_data_with_user_given_names
		
		attributes = {author: "Kirja", year: "2014"}
		expect(IdGenerator.generate_id(attributes)).to eq("Kir2014zzzc")
	end
	
	it "Database doesn't contain generated reference names" do
		attributes = {author: "test", year: "2014"}
		expect(IdGenerator.generate_id(attributes)).to eq("Tes2014")
	end
	
	it "Book with editor" do
		generate_data_with_generated_names
		generate_data_with_user_given_names
		
		attributes = {editor: "Edit", year: "2014"}
		expect(IdGenerator.generate_id(attributes)).to eq("Edi2014")
	end
	
	it "Book with editor and author" do
		generate_data_with_generated_names
		generate_data_with_user_given_names
		
		attributes = {editor: "Edit", author: "Aut", year: "2014"}
		expect(IdGenerator.generate_id(attributes)).to eq("AutEdi2014")
	end
	
	it "ABC Test" do
		reference = Reference.new(name: "Abc2014", ref_type: "book")
    	reference.reference_attributes = [FactoryGirl.create(:reference_attribute, name: "author", value: "ABC"),
                                       FactoryGirl.create(:reference_attribute, name:"title", value: "Aapinen"),
                                       FactoryGirl.create(:reference_attribute, name:"publisher", value: "otava"),
                                       FactoryGirl.create(:reference_attribute, name:"year", value: "2014")]
    	reference.save
    	attributes = {author: "ABC", year: "2014"}
		expect(IdGenerator.generate_id(attributes)).to eq("Abc2014a")
	end
	
	it "More than one author" do
    	attributes = {author: "ABC, Testaaja", year: "2014"}
    	expect(IdGenerator.generate_id(attributes)).to eq("AbcTes2014")
	end
	
	# Help methods
	
	def generate_data_with_generated_names
		reference = Reference.new(name: "Tes2014b", ref_type: "book")
    	reference.reference_attributes = [FactoryGirl.create(:reference_attribute, name: "author", value: "kalle ilves"),
                                       FactoryGirl.create(:reference_attribute, name:"title", value: "kallen kokkikirja"),
                                       FactoryGirl.create(:reference_attribute, name:"publisher", value: "otava"),
                                       FactoryGirl.create(:reference_attribute, name:"year", value: "2014")]
    	reference.save

    	reference = Reference.new(name: "Tes2014za", ref_type: "article")
    	reference.reference_attributes = [FactoryGirl.create(:reference_attribute, name:"author", value: "henri korpela"),
                                       FactoryGirl.create(:reference_attribute, name:"title", value: "pullien paiston ABC"),
                                       FactoryGirl.create(:reference_attribute, name:"journal", value: "keittokirja"),
                                       FactoryGirl.create(:reference_attribute, name:"year", value: "2014")]
    	reference.save

    	reference = Reference.new(name: "Tes2014zd", ref_type: "inproceedings")
    	reference.reference_attributes = [FactoryGirl.create(:reference_attribute, name:"author", value: "henri korpela"),
                                       FactoryGirl.create(:reference_attribute, name:"title", value: "Croisantin syonnin taito"),
                                       FactoryGirl.create(:reference_attribute, name:"booktitle", value: "Croisanttien maailma"),
                                       FactoryGirl.create(:reference_attribute, name:"year", value: "2014")]
    	reference.save
    	
    	reference = Reference.new(name: "Tes2014zb", ref_type: "inproceedings")
    	reference.reference_attributes = [FactoryGirl.create(:reference_attribute, name:"author", value: "henri korpela"),
                                       FactoryGirl.create(:reference_attribute, name:"title", value: "Croisantin syonnin taito"),
                                       FactoryGirl.create(:reference_attribute, name:"booktitle", value: "Croisanttien maailma"),
                                       FactoryGirl.create(:reference_attribute, name:"year", value: "2014")]
    	reference.save
    	    	
    	reference = Reference.new(name: "Kir2014zzzb", ref_type: "inproceedings")
    	reference.reference_attributes = [FactoryGirl.create(:reference_attribute, name:"author", value: "henri korpela"),
                                       FactoryGirl.create(:reference_attribute, name:"title", value: "Croisantin syonnin taito"),
                                       FactoryGirl.create(:reference_attribute, name:"booktitle", value: "Croisanttien maailma"),
                                       FactoryGirl.create(:reference_attribute, name:"year", value: "2014")]
    	reference.save
    	
    	reference = Reference.new(name: "Kir2014zzza", ref_type: "inproceedings")
    	reference.reference_attributes = [FactoryGirl.create(:reference_attribute, name:"author", value: "henri korpela"),
                                       FactoryGirl.create(:reference_attribute, name:"title", value: "Croisantin syonnin taito"),
                                       FactoryGirl.create(:reference_attribute, name:"booktitle", value: "Croisanttien maailma"),
                                       FactoryGirl.create(:reference_attribute, name:"year", value: "2014")]
    	reference.save
	end
	
	def generate_data_with_user_given_names
		reference = Reference.new(name: "kirja34", ref_type: "book")
    	reference.reference_attributes = [FactoryGirl.create(:reference_attribute, name: "author", value: "kalle ilves"),
                                       FactoryGirl.create(:reference_attribute, name:"title", value: "kallen kokkikirja"),
                                       FactoryGirl.create(:reference_attribute, name:"publisher", value: "otava"),
                                       FactoryGirl.create(:reference_attribute, name:"year", value: "2014")]
    	reference.save

    	reference = Reference.new(name: "royce70", ref_type: "article")
    	reference.reference_attributes = [FactoryGirl.create(:reference_attribute, name:"author", value: "henri korpela"),
                                       FactoryGirl.create(:reference_attribute, name:"title", value: "pullien paiston ABC"),
                                       FactoryGirl.create(:reference_attribute, name:"journal", value: "keittokirja"),
                                       FactoryGirl.create(:reference_attribute, name:"year", value: "2014")]
    	reference.save

    	reference = Reference.new(name: "Munkki12Arnolds", ref_type: "inproceedings")
    	reference.reference_attributes = [FactoryGirl.create(:reference_attribute, name:"author", value: "henri korpela"),
                                       FactoryGirl.create(:reference_attribute, name:"title", value: "Croisantin syonnin taito"),
                                       FactoryGirl.create(:reference_attribute, name:"booktitle", value: "Croisanttien maailma"),
                                       FactoryGirl.create(:reference_attribute, name:"year", value: "2014")]
    	reference.save
    	
    	reference = Reference.new(name: "SkanditTaal", ref_type: "inproceedings")
    	reference.reference_attributes = [FactoryGirl.create(:reference_attribute, name:"author", value: "henri korpela"),
                                       FactoryGirl.create(:reference_attribute, name:"title", value: "Croisantin syonnin taito"),
                                       FactoryGirl.create(:reference_attribute, name:"booktitle", value: "Croisanttien maailma"),
                                       FactoryGirl.create(:reference_attribute, name:"year", value: "2014")]
    	reference.save
	end
end