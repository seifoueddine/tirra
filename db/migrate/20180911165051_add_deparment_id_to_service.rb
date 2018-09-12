class AddDeparmentIdToService < ActiveRecord::Migration[5.1]
  def change
    add_column :services, :department_id, :integer
  end
end
