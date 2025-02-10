class Category < ApplicationRecord
  belongs_to :menu
  has_many :items, dependent: :destroy

  accepts_nested_attributes_for :items, allow_destroy: true, reject_if: :all_blank
end
