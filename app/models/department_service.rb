class DepartmentService < ApplicationRecord
  belongs_to :department
  belongs_to :service
end
