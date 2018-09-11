class AddRemiseToProductSales < ActiveRecord::Migration[5.1]
  def change
    add_column :product_sales, :remise, :float
  end
end
