class Dog < ActiveRecord::Base
	has_many :relationships
	has_many :owners, through: :relationships

	#===============trying this to tie dog and owner together====
	accepts_nested_attributes_for :relationships
	#=========================================================
end
