require 'spec_helper'

describe "reference_attributes/index" do
  before(:each) do
    assign(:reference_attributes, [
      stub_model(ReferenceAttribute,
        :reference_id => 1,
        :name => "MyText",
        :value => "MyText"
      ),
      stub_model(ReferenceAttribute,
        :reference_id => 1,
        :name => "MyText",
        :value => "MyText"
      )
    ])
  end

  it "renders a list of reference_attributes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
