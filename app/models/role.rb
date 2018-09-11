class Role < ApplicationRecord

  has_many :contact_roles
  has_many :contacts ,through: :contact_roles

  scope :all_except, ->(s) { where.not(id: s) }

end
