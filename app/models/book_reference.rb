class BookReference
	include ActiveModel::Model

	def self.available_attributes
		return ["author", "title", "publisher", "year", "volume", "series", "address", "edition", "month", "note", "key"]
	end

	def self.required_attributes
		return ["author", "title", "publisher", "year"]
	end
end