class AddDepartmentIdAndServiceIdToUser < ActiveRecord::Migration[5.2]
  def change

    add_column :users, :department_id, :integer
    add_column :users, :service_id, :integer

  end
end
