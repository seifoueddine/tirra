class Contact < ApplicationRecord
has_many :contact_roles
has_many :roles ,through: :contact_roles
  has_many :sales
  has_many :purchases
end
