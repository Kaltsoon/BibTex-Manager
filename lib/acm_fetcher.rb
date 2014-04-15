module AcmFetcher
	extend ActiveSupport::Concern

	require "nokogiri"
	require "open-uri"

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
		id = url.slice((url.rindex("?id=")+4)..url.length)
		return "http://dl.acm.org/exportformats.cfm?id=#{id}&expformat=bibtex"
	end

end