require 'bcrypt'
class Owner < ActiveRecord::Base
	has_many :relationships
	has_many :dogs, through: :relationships
	has_secure_password #made available from the bcrypt gem

	def full_name
		"#{first_name} #{last_name}" #This allows you to show full name for the collection select when adding dog and owner relationships
	end
end
