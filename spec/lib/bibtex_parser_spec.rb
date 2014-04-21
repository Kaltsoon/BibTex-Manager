
require "spec_helper"

include BibtexParser

describe "BibtexParser" do

  it "generates valid reference from single bibtex reference" do
    inproceedings = "@inproceedings{Singer:2003:SBN:1085714.1085771,
author = {Singer, Eric},
title = {Sonic Banana: A Novel Bend-sensor-based MIDI Controller},
booktitle = {Proceedings of the 2003 Conference on New Interfaces for Musical Expression},
series = {NIME '03},
year = {2003},
location = {Montreal, Quebec, Canada},
pages = {220--221},
numpages = {2},
url = {http://dl.acm.org/citation.cfm?id=1085714.1085771},
acmid = {1085771},
publisher = {National University of Singapore},
address = {Singapore, Singapore},
keywords = {MIDI, bend, controller, interactive, performance, sensors},
}"
    valid = {
      author:  "Singer, Eric",
      title:  "Sonic Banana: A Novel Bend-sensor-based MIDI Controller",
      booktitle:  "Proceedings of the 2003 Conference on New Interfaces for Musical Expression",
      series:  "NIME '03",
      year:  "2003",
      pages:  "220--221",
      publisher:  "National University of Singapore",
      address:  "Singapore, Singapore"
    }
    #hajoo
    #reference = parse_bibtex_references inproceedings
    attributes = reference.reference_attributes
    attributes.each do |attribute|
      expect(attribute.value).to eq(valid[attribute.name])
    end
  end
end