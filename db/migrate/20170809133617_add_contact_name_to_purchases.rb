class AddContactNameToPurchases < ActiveRecord::Migration[5.1]
  def change
    add_column :purchases, :contact_name, :string
  end
end
