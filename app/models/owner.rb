class Owner < ActiveRecord::Base
	has_many :relationships
	has_many :dogs, through: :relationships
end
