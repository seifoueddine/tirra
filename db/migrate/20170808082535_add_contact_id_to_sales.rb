class AddContactIdToSales < ActiveRecord::Migration[5.1]
  def change
    add_column :sales, :contact_id, :integer
  end
end
