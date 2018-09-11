class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :code
      t.string :designation
      t.string :name
      t.float :price

      t.timestamps
    end
  end
end
