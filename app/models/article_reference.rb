class ArticleReference
	include ActiveModel::Model

	def self.get_available_attributes
		return ["author", "title", "journal", "year", "volume", "number", "pages", "month", "note", "key", "publisher", "address"]
	end

	def self.fields_to_render
		return ["author", "title", "journal", "year"]
	end

	def self.get_required_attributes
		return ["author", "title", "journal", "year"]
	end

	def self.fills_required_attributes?(attributes)
		return (ArticleReference.get_required_attributes-attributes).empty?
	end

end