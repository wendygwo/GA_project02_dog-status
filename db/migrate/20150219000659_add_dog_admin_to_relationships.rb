class AddDogAdminToRelationships < ActiveRecord::Migration
  def change
    add_column :relationships, :is_dog_admin, :boolean
  end
end
