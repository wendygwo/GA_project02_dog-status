class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.belongs_to :dog, index: true
      t.belongs_to :owner, index: true

      t.timestamps
    end
  end
end
