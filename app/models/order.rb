class Order < ApplicationRecord
  belongs_to :user
  belongs_to :menu
  has_many :item_orders
  has_many :items, through: :item_orders
end
