require 'spec_helper'

describe "references/new" do
  before(:each) do
    assign(:reference, stub_model(Reference,
      :type => "MyText",
      :name => "MyText"
    ).as_new_record)
  end

  it "renders new reference form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", references_path, "post" do
      assert_select "textarea#reference_type[name=?]", "reference[type]"
      assert_select "textarea#reference_name[name=?]", "reference[name]"
    end
  end
end
