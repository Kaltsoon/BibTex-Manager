class BookReference
	include ActiveModel::Model

	def self.get_available_attributes
		return ["author", "title", "publisher", "year", "volume", "series", "address", "edition", "month", "note", "key"]
	end

	def self.get_required_attributes
		return ["author", "title", "publisher", "year"]
	end
end