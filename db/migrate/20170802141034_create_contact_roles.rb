class CreateContactRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :contact_roles do |t|
      t.integer :contact_id
      t.integer :role_id

      t.timestamps
    end
  end
end
