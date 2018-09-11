class AddBonusToProductSales < ActiveRecord::Migration[5.1]
  def change
    add_column :product_sales, :bonus, :string
  end
end
