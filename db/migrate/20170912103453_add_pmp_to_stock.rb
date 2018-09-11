class AddPmpToStock < ActiveRecord::Migration[5.1]
  def change
    add_column :stocks, :pmp, :float
  end
end
