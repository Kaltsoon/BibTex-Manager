class Reference < ActiveRecord::Base
	has_many :reference_attributes, dependent: :destroy
	validates :name, uniqueness: true, presence: true
	validates :ref_type, presence: true
	validate :reference_attributes, :validate_required_attributes
	validate :ref_type, :validate_type

	def has_required_attribute?(attribute)
		return "#{ref_type.downcase.capitalize}Reference".constantize.get_required_attributes.include?(attribute.name)
	end

	def get_available_attributes()
		return "#{ref_type.downcase.capitalize}Reference".constantize.get_available_attributes
	end

	def get_required_attributes()
		return "#{ref_type.downcase.capitalize}Reference".constantize.get_required_attributes
	end

	def get_attributes_not_set()
		return get_available_attributes - reference_attributes.map{|a| a.name}
	end

	def self.get_available_types
		return ["book", "article", "proceedings"]
	end

	private

	def validate_type
		if(not Reference.get_available_types.include?(ref_type))
			errors.add(:reference_attributes, "reference type is not valid!")
		end
	end

	def validate_required_attributes
		if(not (get_required_attributes-reference_attributes.map{|a| a.name}).empty?)
			errors.add(:reference_attributes, "reference needs to have all required attributes!")
		end
	end

	def valivade_attributes
		if(not (reference_attributes.map{|a| a.name}-get_available_attributes).empty?)
			errors.add(:reference_attributes, "reference attributes are not valid!")
		end
	end
end
