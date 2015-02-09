class CreateDogs < ActiveRecord::Migration
  def change
    create_table :dogs do |t|
      t.string :dog_name
      t.string :breed
      t.date :birthday
      t.boolean :food_low_flag
      t.boolean :treats_low_flag
      t.string :photo_path

      t.timestamps
    end
  end
end
