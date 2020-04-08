class AddActiveTenantToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :active_tenant_id, :string
  end
end
