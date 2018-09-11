class AddAmountToProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :amount, :integer
  end
end
