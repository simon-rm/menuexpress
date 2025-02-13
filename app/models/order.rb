class Order < ApplicationRecord
  belongs_to :user
  belongs_to :menu
  has_many :item_orders
  has_many :items, through: :item_orders

  accepts_nested_attributes_for :item_orders, allow_destroy: true,
                                reject_if: proc { |attr| attr[:quantity].to_i <= 0 }
end
