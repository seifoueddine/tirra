class AddCustomerIdToSales < ActiveRecord::Migration[5.1]
  def change
    add_column :sales, :customer_id, :integer
  end
end
