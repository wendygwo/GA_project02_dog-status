class AddPasswordResetToOwners < ActiveRecord::Migration
  def change
    add_column :owners, :password_reset_token, :string
    add_column :owners, :password_reset_sent_at, :datetime
  end
end
