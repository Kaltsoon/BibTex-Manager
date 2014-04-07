class BookReference
	include ActiveModel::Model

	def self.get_available_attributes
		return ["author", "editor", "title", "publisher", "year", "volume", "series", "address", "edition", "month", "note", "key"]
	end

	def self.fields_to_render
		return ["title", "publisher", "year"]
	end

	def self.get_required_attributes
		return ["title", "publisher", "year"]
	end

	def self.fills_required_attributes?(attributes)
		return ((BookReference.get_required_attributes-attributes).empty? and (attributes.include?("editor") or attributes.include?("author")))
	end
	
end