require 'spec_helper'

describe "reference_attributes/show" do
  before(:each) do
    @reference_attribute = assign(:reference_attribute, stub_model(ReferenceAttribute,
      :reference_id => 1,
      :name => "MyText",
      :value => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
  end
end
