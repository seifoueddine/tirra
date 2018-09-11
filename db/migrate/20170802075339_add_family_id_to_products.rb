class AddFamilyIdToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :family_id, :integer
  end
end
