class Purchase < ApplicationRecord

  has_many :product_purchases
  has_many :products, through: :product_purchases
  belongs_to :contact

  has_attached_file :document
  validates_attachment :document, :content_type => { :content_type => %w(application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document) }
end
