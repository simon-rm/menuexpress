class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :items, through: :order_items

  def menu
    items.first.menu
  end

  enum :status, %i[
    pending confirmed preparing ready in_transit delivered canceled failed
  ]
end
