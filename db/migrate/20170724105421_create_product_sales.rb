class CreateProductSales < ActiveRecord::Migration[5.1]
  def change
    create_table :product_sales do |t|
      t.integer :product_id
      t.integer :sale_id
      t.integer :quantity
      t.float :price

      t.timestamps
    end
  end
end
