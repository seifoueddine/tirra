class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.string :raison
      t.string :phone

      t.timestamps
    end
  end
end
