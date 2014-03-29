class Reference < ActiveRecord::Base
	has_many :reference_attributes, dependent: :destroy
	validates :name, uniqueness: true, presence: true
	validates :ref_type, presence: true

	def has_required_attribute(attribute)
		case ref_type
			when "book"
			  return BookReference.required_attributes.include?(attribute.name)
			when "article"
			  return ArticleReference.required_attributes.include?(attribute.name)
			when "inproceedings"
			  return InproceedingsReference.required_attributes.include?(attribute.name)
			else
			  return false
		end
	end

	def get_available_attributes()
		case ref_type
			when "book"
			  return BookReference.available_attributes
			when "article"
			  return ArticleReference.available_attributes
			when "inproceedings"
			  return InproceedingsReference.available_attributes
			else
			  return []
		end
	end

	def get_attributes_not_set()
		return get_available_attributes - reference_attributes.map{|a| a.name}
	end
end
