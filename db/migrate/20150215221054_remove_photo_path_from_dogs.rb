class RemovePhotoPathFromDogs < ActiveRecord::Migration
  def change
    remove_column :dogs, :photo_path, :string
  end
end
