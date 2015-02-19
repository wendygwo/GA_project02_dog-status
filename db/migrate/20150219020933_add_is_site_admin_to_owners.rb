class AddIsSiteAdminToOwners < ActiveRecord::Migration
  def change
    add_column :owners, :is_site_admin, :boolean
  end
end
