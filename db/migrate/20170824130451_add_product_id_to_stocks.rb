class AddProductIdToStocks < ActiveRecord::Migration[5.1]
  def change
    add_column :stocks, :product_id, :integer
  end
end
