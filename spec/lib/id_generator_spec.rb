
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
		
		attributes = {name: "nimi", author: "Kirja", year: "2014"}
		expect(IdGenerator.generate_id(attributes)).to eq("Kir2014zzzc")
	end
	
	it "Database doesn't contain generated reference names" do
		attributes = {name: "nimi", author: "test", year: "2014"}
		expect(IdGenerator.generate_id(attributes)).to eq("Tes2014")
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