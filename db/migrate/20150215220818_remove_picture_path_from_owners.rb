class RemovePicturePathFromOwners < ActiveRecord::Migration
  def change
    remove_column :owners, :picture_path, :string
  end
end
