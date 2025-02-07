class Menu < ApplicationRecord
  belongs_to :user
  has_many :categories, dependent: :destroy
  has_many :items, through: :categories
end
