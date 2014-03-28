class Reference < ActiveRecord::Base
	has_many :reference_attributes
	validates :name, uniqueness: true
end
