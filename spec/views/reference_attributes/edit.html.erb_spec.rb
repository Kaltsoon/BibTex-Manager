require 'spec_helper'

describe "reference_attributes/edit" do
  before(:each) do
    @reference_attribute = assign(:reference_attribute, stub_model(ReferenceAttribute,
      :reference_id => 1,
      :name => "MyText",
      :value => "MyText"
    ))
  end

  it "renders the edit reference_attribute form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", reference_attribute_path(@reference_attribute), "post" do
      assert_select "input#reference_attribute_reference_id[name=?]", "reference_attribute[reference_id]"
      assert_select "textarea#reference_attribute_name[name=?]", "reference_attribute[name]"
      assert_select "textarea#reference_attribute_value[name=?]", "reference_attribute[value]"
    end
  end
end
