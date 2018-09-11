class Stock < ApplicationRecord

  scope :all_except, ->(u) { where.not(product_id: u) }
end
