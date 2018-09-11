class Product < ApplicationRecord
  has_many :product_purchases
  has_many :purchases, through: :product_purchases

  has_many :product_sales
  has_many :sales,through: :product_sales

  belongs_to :family

  scope :all_except, ->(s) { where.not(id: s) }

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
