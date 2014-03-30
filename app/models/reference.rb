class Reference < ActiveRecord::Base
	has_many :reference_attributes, dependent: :destroy
	validates :name, uniqueness: true, presence: true
	validates :ref_type, presence: true

	def has_required_attribute?(attribute)
		return "#{ref_type.downcase.capitalize}Reference".constantize.required_attributes.include?(attribute.name)
	end

	def get_available_attributes()
		return "#{ref_type.downcase.capitalize}Reference".constantize.available_attributes
	end

	def get_attributes_not_set()
		return get_available_attributes - reference_attributes.map{|a| a.name}
	end
end
