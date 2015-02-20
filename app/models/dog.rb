class Dog < ActiveRecord::Base
	#the dependent: :destroy will destroy all associated records when a dog is deleted. It won't delete the owner
	has_many :relationships, dependent: :destroy 
	has_many :owners, through: :relationships
	#the dependent: :destroy will destroy all status records when a dog is deleted.
	has_many :statuses, dependent: :destroy

	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
	#===============trying this to tie dog and owner together====
	accepts_nested_attributes_for :relationships
	#=========================================================
end
