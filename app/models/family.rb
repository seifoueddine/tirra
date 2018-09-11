class Family < ApplicationRecord
  belongs_to :parent, class_name:"Family", required: false
  has_many :children, class_name:"Family", foreign_key: "parent_id"
  has_many :products
end
def parent_name
  # it may not have a parent
  parent.try(:name)
end

def has_parent?
  parent.present?
end

def has_children?
  children.exists?
end