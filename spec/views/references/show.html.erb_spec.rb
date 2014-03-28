require 'spec_helper'

describe "references/show" do
  before(:each) do
    @reference = assign(:reference, stub_model(Reference,
      :type => "MyText",
      :name => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
  end
end
