require 'spec_helper'

describe "references/index" do
  before(:each) do
    assign(:references, [
      stub_model(Reference,
        :type => "MyText",
        :name => "MyText"
      ),
      stub_model(Reference,
        :type => "MyText",
        :name => "MyText"
      )
    ])
  end

  it "renders a list of references" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
