class AddRoleIdToContact < ActiveRecord::Migration[5.1]
  def change
    add_column :contacts, :role_id, :integer
  end
end
