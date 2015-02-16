class AddImageToOwner < ActiveRecord::Migration
  def self.up
  	add_attachment :owners, :image
  end
  def self.down
  	remove_attachment :owners, :image
  end
end
