class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.boolean :is_fed_breakfast
      t.boolean :is_fed_dinner
      t.boolean :is_walked
      t.integer :num_treats_given
      t.text :notes
      t.belongs_to :dog, index: true

      t.timestamps
    end
  end
end
