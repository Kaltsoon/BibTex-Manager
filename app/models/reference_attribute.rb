class ReferenceAttribute < ActiveRecord::Base
	belongs_to :reference
	validates :name, uniqueness: { scope: :reference_id }, presence: true
	validates :value, presence: true
	validate :name, :validate_attribute

	private

	def validate_attribute
		if(not reference.nil? and not (reference.get_available_attributes).include?(name))
			errors.add(:name, "is not valid!")
		end
	end
end
