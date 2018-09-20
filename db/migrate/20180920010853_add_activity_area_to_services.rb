class AddActivityAreaToServices < ActiveRecord::Migration[5.2]
  def change
    add_column :services, :activity_area, :string
  end
end
