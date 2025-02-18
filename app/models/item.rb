class Item < ApplicationRecord
  belongs_to :category
  has_one :menu, through: :category
end
