require "spec_helper"

describe "BibTex file download" do
	it "can click link to download the file" do
		visit references_path
		page.find("#download_bibtex_link").click
	end
end