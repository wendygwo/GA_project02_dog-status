class AddEmailToOwners < ActiveRecord::Migration
  def change
    add_column :owners, :email, :string
  end
end
