class OrderItem < ApplicationRecord
  belongs_to :item
  belongs_to :order

  has_one :menu, through: :item
end
