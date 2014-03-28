require 'spec_helper'

describe "reference_attributes/new" do
  before(:each) do
    assign(:reference_attribute, stub_model(ReferenceAttribute,
      :reference_id => 1,
      :name => "MyText",
      :value => "MyText"
    ).as_new_record)
  end

  it "renders new reference_attribute form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", reference_attributes_path, "post" do
      assert_select "input#reference_attribute_reference_id[name=?]", "reference_attribute[reference_id]"
      assert_select "textarea#reference_attribute_name[name=?]", "reference_attribute[name]"
      assert_select "textarea#reference_attribute_value[name=?]", "reference_attribute[value]"
    end
  end
end
