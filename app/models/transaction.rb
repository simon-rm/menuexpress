class Transaction < ApplicationRecord
  belongs_to :order
  store_accessor :payment_data, :response, :status
end
