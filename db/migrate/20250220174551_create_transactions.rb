class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.jsonb :prepayment_data
      t.jsonb :payment_data
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
