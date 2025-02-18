class Order < ApplicationRecord
  belongs_to :user
  belongs_to :menu
  has_many :order_items, dependent: :destroy
  has_many :items, through: :order_items

  enum :status, %i[
    pending confirmed preparing ready in_transit delivered canceled failed
  ]
end
