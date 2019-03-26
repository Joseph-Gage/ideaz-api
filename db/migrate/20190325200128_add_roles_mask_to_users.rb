class AddRolesMaskToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :roles_mask, :integer, default: 1
  end
end
