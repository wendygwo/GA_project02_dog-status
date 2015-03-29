require 'bcrypt'
class Owner < ActiveRecord::Base
	has_many :relationships, dependent: :destroy
	has_many :dogs, through: :relationships
	has_secure_password #made available from the bcrypt gem

	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
	# Validate size of attached image is less than 1MB
  validates_with AttachmentSizeValidator, :attributes => :image, :less_than => 1.megabytes

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
	def send_password_reset
	  generate_token(:password_reset_token)
	  # raise params.inspect
	  self.password_reset_sent_at = Time.zone.now
	  self.password='rieowoqpwiwqj'
	  save!
	  OwnerMailer.forgot_password(self).deliver# This sends an e-mail with a link for the user to reset the password
	end
	# This generates a random password reset token for the user
	def generate_token(column)
	  begin
	    self[column] = SecureRandom.urlsafe_base64
	  end while Owner.exists?(column => self[column])
	end
end
