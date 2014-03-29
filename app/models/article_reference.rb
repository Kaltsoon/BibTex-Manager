class ArticleReference
	include ActiveModel::Model

	def self.available_attributes
		return ["author", "title", "journal", "year", "volume", "number", "pages", "month", "note", "key"]
	end

	def self.required_attributes
		return ["author", "title", "journal", "year"]
	end
end