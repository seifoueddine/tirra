class ContactRole < ApplicationRecord

  belongs_to :role
  belongs_to :contact
end
