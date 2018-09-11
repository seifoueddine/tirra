class AddAuthorizerToSales < ActiveRecord::Migration[5.1]
  def change
    add_column :sales, :authorizer, :string
  end
end
