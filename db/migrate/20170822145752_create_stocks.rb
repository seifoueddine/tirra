class CreateStocks < ActiveRecord::Migration[5.1]
  def change
    create_table :stocks do |t|
      t.string :code
      t.string :designation
      t.integer :amount

      t.timestamps
    end
  end
end
