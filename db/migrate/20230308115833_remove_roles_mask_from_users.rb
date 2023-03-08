class RemoveRolesMaskFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :roles_mask, :integer
  end
end
