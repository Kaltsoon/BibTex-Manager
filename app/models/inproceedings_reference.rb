class InproceedingsReference
	include ActiveModel::Model

	def self.available_attributes
		return ["author", "title", "booktitle", "year", "editor", "volume", "series", "pages", "address", "month", "organization", "publisher", "note", "key"]
	end

	def self.required_attributes
		return ["author", "title", "booktitle", "year"]
	end
end