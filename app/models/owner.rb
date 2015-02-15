require 'bcrypt'
class Owner < ActiveRecord::Base
	has_many :relationships
	has_many :dogs, through: :relationships
	has_secure_password #made available from the bcrypt gem

	# validates_uniqueness_of :username, message:'This username is already taken'
	# validates_presence_of :first_name, message:'First name is required'
	# validates_presence_of :last_name, message:'Last name is required'
	# validates_presence_of :password, message:'Password is required'
	# validates_presence_of :password_confirmation, message:'Password is required'
	def full_name
		"#{first_name} #{last_name}" #This allows you to show full name for the collection select when adding dog and owner relationships
	end
end
