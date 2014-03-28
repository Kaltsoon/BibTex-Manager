require 'spec_helper'

describe "references/edit" do
  before(:each) do
    @reference = assign(:reference, stub_model(Reference,
      :type => "MyText",
      :name => "MyText"
    ))
  end

  it "renders the edit reference form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", reference_path(@reference), "post" do
      assert_select "textarea#reference_type[name=?]", "reference[type]"
      assert_select "textarea#reference_name[name=?]", "reference[name]"
    end
  end
end
