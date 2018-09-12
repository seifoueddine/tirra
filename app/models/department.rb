class Department < ApplicationRecord
  belongs_to :user
  has_many :department_services
  has_many :services ,through: :department_services
end
