require 'bcrypt'
class Owner < ActiveRecord::Base
	has_many :relationships, dependent: :destroy
	has_many :dogs, through: :relationships
	has_secure_password #made available from the bcrypt gem

	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

	# Form validations
	validates :username, presence: {message:'You must enter a username!'}
	validates :username, length: {minimum: 5, message:'Username must be at least 5 characters long.'}
	validates :username, uniqueness: {message: 'Please choose another username. This one has already been taken.'}

	validates :email, uniqueness: {message: 'This e-mail has already been registered by another user!'}
	validates :email, format:{with: /\A[\w+\-.]+@[a-zA-Z\d\-]+\.[a-zA-Z]+\z/, message:'Invalid e-mail format.'}

	validates :first_name, presence: {message:'First name is required.'}
	validates :last_name, presence: {message:'Last name is required.'}

	validates :password, length: {minimum: 8, message:'Password must be at least 8 characters long.'}

	def full_name
		"#{first_name} #{last_name}" #This allows you to show full name for the collection select when adding dog and owner relationships
	end
end
