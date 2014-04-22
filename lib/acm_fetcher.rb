module AcmFetcher
	
	extend ActiveSupport::Concern

	require "nokogiri"
	require "open-uri"
	require "addressable/uri"


	def fetch_bibtex_from_acm(url)
		bibtex = ""
		begin
			html_doc = Nokogiri::HTML(open(parse_url(url)))
			html_doc.css("pre").each do |el|
				bibtex = el.content
			end
		rescue Exception => e
			return ""
		end
		return bibtex
	end

	private

	def parse_url(url)
		uri = Addressable::URI.parse(url)
		id = uri.query_values["id"].include?(".") ? uri.query_values["id"].split(".")[1] : uri.query_values["id"]
		return "http://dl.acm.org/exportformats.cfm?id=#{id}&expformat=bibtex"
	end

end