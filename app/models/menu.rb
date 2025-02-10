class Menu < ApplicationRecord
  belongs_to :user
  has_many :categories, dependent: :destroy
  has_many :items, through: :categories

  accepts_nested_attributes_for :categories, allow_destroy: true, reject_if: :all_blank
end
