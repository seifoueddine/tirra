class CreateProductPurchases < ActiveRecord::Migration[5.1]
  def change
    create_table :product_purchases do |t|
      t.integer :product_id
      t.integer :purchase_id
      t.integer :quantity
      t.float :price

      t.timestamps
    end
  end
end
