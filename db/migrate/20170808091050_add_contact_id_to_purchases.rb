class AddContactIdToPurchases < ActiveRecord::Migration[5.1]
  def change
    add_column :purchases, :contact_id, :integer
  end
end
