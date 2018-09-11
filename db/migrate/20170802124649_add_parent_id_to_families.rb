class AddParentIdToFamilies < ActiveRecord::Migration[5.1]
  def change
    add_column :families, :parent_id, :integer
  end
end
