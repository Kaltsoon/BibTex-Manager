
require "spec_helper"

include BibtexParser

describe "BibtexParser" do

  it "generates valid reference from single bibtex reference" do

    inproceedings = "@inproceedings{Luukkainen:2012:TYD:2380552.2380613,
        author = {Luukkainen, Matti and Vihavainen, Arto and Vikberg, Thomas},
        title = {Three Years of Design-based Research to Reform a Software Engineering Curriculum},
        booktitle = {Proceedings of the 13th Annual Conference on Information Technology Education},
        series = {SIGITE '12},
        year = {2012},
        pages = {209--214},
        publisher = {ACM},
        address = {New York, NY, USA}}"
    valid = {
      author:  "Luukkainen, Matti and Vihavainen, Arto and Vikberg, Thomas",
      title:  "Three Years of Design-based Research to Reform a Software Engineering Curriculum",
      booktitle:  "Proceedings of the 13th Annual Conference on Information Technology Education",
      series:  "SIGITE '12",
      year:  "2012",
      pages:  "209--214",
      publisher:  "ACM",
      address:  "New York, NY, USA"
    }
  end
end