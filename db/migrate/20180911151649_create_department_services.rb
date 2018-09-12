class CreateDepartmentServices < ActiveRecord::Migration[5.1]
  def change
    create_table :department_services do |t|
      t.integer :department_id
      t.integer :service_id

      t.timestamps
    end
  end
end
