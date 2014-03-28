class ReferenceAttribute < ActiveRecord::Base
	belongs_to :reference
	validates :name, uniqueness: { scope: :reference_id }
end
