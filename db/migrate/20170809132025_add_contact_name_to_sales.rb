class AddContactNameToSales < ActiveRecord::Migration[5.1]
  def change
    add_column :sales, :contact_name, :string
  end
end
