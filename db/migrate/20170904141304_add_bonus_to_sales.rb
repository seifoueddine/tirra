class AddBonusToSales < ActiveRecord::Migration[5.1]
  def change
    add_column :sales, :bonus, :integer
  end
end
