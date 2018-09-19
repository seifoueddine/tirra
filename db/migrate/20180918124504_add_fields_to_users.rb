class AddFieldsToUsers < ActiveRecord::Migration[5.2]
  def change

    add_column :users, :business_address, :string
    add_column :users, :workplace, :string
    add_column :users, :professional_mobile, :string
    add_column :users, :professional_telephone, :string

    add_column :users, :post, :string
    add_column :users, :post_occupied, :string
    add_column :users, :administrator, :string
    add_column :users, :mentor, :string
    add_column :users, :legal_hours_of_work, :integer
    add_column :users, :number_identification, :integer
    add_column :users, :number_piece_identity, :integer
    add_column :users, :bank_account_number, :bigint
    add_column :users, :social_security_number, :bigint
    add_column :users, :sex, :string
    add_column :users, :marital_statue, :string
    add_column :users, :working_license, :string
    add_column :users, :visas, :string
    add_column :users, :work_permit_number, :integer


    add_column :users, :expiry_date_visa, :datetime
    add_column :users, :contact_information, :string
    add_column :users, :birth_date, :datetime
    add_column :users, :place_of_birth, :string
    add_column :users, :personal_address, :string

    add_column :users, :presence, :string
    add_column :users, :linked_user, :string
    add_column :users, :IDBadge, :integer

  end
end
