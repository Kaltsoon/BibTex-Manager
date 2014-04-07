#encoding: utf-8

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

  it "generates valid bibtex string with scandic letters in attributes" do
    reference1 = Reference.new(name: "Kirja", ref_type: "book")
    reference1.reference_attributes = [FactoryGirl.create(:reference_attribute, name: "author", value: "Mörkö"),
                                       FactoryGirl.create(:reference_attribute, name:"title", value: "Hölmö kirja"),
                                       FactoryGirl.create(:reference_attribute, name:"publisher", value: "Äitis"),
                                       FactoryGirl.create(:reference_attribute, name:"year", value: "2014")]
    reference1.save

    reference2 = Reference.new(name: "Artikkeli", ref_type: "article")
    reference2.reference_attributes = [FactoryGirl.create(:reference_attribute, name:"author", value: "Örkki Mörkki"),
                                       FactoryGirl.create(:reference_attribute, name:"title", value: "Hölöködöö"),
                                       FactoryGirl.create(:reference_attribute, name:"journal", value: "keittokirja"),
                                       FactoryGirl.create(:reference_attribute, name:"year", value: "2014")]
    reference2.save

    reference3 = Reference.new(name: "Joku", ref_type: "inproceedings")
    reference3.reference_attributes = [FactoryGirl.create(:reference_attribute, name:"author", value: "Mäntti Päntti"),
                                       FactoryGirl.create(:reference_attribute, name:"title", value: "Ääpinen"),
                                       FactoryGirl.create(:reference_attribute, name:"booktitle", value: "ääpinen"),
                                       FactoryGirl.create(:reference_attribute, name:"year", value: "2014")]
    reference3.save

    expect(generate_bibtex_string([reference1])).to eq("@book{Kirja,\n\tauthor = {M\\\"{o}rk\\\"{o}},\n\ttitle = {H\\\"{o}lm\\\"{o} kirja},\n\tpublisher = {\\\"{A}itis},\n\tyear = {2014}\n}")
    expect(generate_bibtex_string([reference2])).to eq("@article{Artikkeli,\n\tauthor = {\\\"{O}rkki M\\\"{o}rkki},\n\ttitle = {H\\\"{o}l\\\"{o}k\\\"{o}d\\\"{o}\\\"{o}},\n\tjournal = {keittokirja},\n\tyear = {2014}\n}")
    expect(generate_bibtex_string([reference3])).to eq("@inproceedings{Joku,\n\tauthor = {M\\\"{a}ntti P\\\"{a}ntti},\n\ttitle = {\\\"{A}\\\"{a}pinen},\n\tbooktitle = {\\\"{a}\\\"{a}pinen},\n\tyear = {2014}\n}")
  end
end