class ArticleReference
	include ActiveModel::Model

	def self.get_available_attributes
		return ["author", "title", "journal", "year", "volume", "number", "pages", "month", "note", "key"]
	end

	def self.get_required_attributes
		return ["author", "title", "journal", "year"]
	end
end