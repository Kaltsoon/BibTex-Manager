require "spec_helper"

describe "BibTex file download" do
	it "can click the link to download the file" do
		visit references_path
		expect(page).to have_content "Download all references"
		visit download_all_references_path
	end
end