class AddImageToDog < ActiveRecord::Migration
	def self.up
		add_attachment :dogs, :image
	end

	def self.down
		remove_attachment :dogs, :image
	end
end
