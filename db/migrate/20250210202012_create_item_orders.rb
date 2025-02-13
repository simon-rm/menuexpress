class CreateItemOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :item_orders do |t|
      t.references :item, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true
      t.integer :quantity
      t.float :price

      t.timestamps
    end
  end
end
