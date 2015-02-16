class Dog < ActiveRecord::Base
	has_many :relationships
	has_many :owners, through: :relationships

	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
	#===============trying this to tie dog and owner together====
	accepts_nested_attributes_for :relationships
	#=========================================================
end
