class Dog < ActiveRecord::Base
	has_many :relationships
	has_many :owners, through: :relationships
end
