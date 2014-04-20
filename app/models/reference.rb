class Reference < ActiveRecord::Base
	include BibtexGenerator

	has_many :reference_attributes, dependent: :destroy
	
	validates :name, uniqueness: true, presence: true
	validates :ref_type, presence: true
	validate :reference_attributes, :validate_required_attributes
	validate :ref_type, :validate_type

	def get_bibtex
		return generate_bibtex_string([self]).gsub(/(?:\n\r?|\r\n?)/, "<br>").gsub(/(?:\t\r?|\r\t?)/, "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
	end

	def can_remove_attribute?(attribute)
		return get_type_instance.fills_required_attributes?(reference_attributes.map{|a| a.name}-[attribute.name])
	end

	def get_available_attributes()
		return get_type_instance.get_available_attributes
	end

	def get_required_attributes()
		return get_type_instance.get_required_attributes
	end

	def get_attributes_not_set()
		return get_available_attributes - reference_attributes.map{|a| a.name}
	end

	def self.get_available_types
		return ["book", "article", "inproceedings"]
	end

	def fills_required_attributes?
		if(Reference.get_available_types.include?(ref_type))
			return get_type_instance.fills_required_attributes?(reference_attributes.map{|a| a.name})
		else
			return false
		end
	end

	private

	def get_type_instance
		return "#{ref_type.downcase.capitalize}Reference".constantize
	end

	def validate_type
		if(not Reference.get_available_types.include?(ref_type))
			errors.add(:ref_type, "is not valid!")
		end
	end


	def validate_required_attributes
		if(not fills_required_attributes?)
			errors.add(:reference_attributes, "needs to have all the required attributes!")
		end
	end

end
