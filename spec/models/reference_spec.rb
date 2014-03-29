require 'spec_helper'

describe Reference do
  it "is not saved if name not set" do
  	reference = Reference.new(name: "kirja1", ref_type: "book")
  	expect(reference).to be_valid
  end
end
