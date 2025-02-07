class CreateItems < ActiveRecord::Migration[8.0]
  def change
    create_table :items do |t|
      t.string :name
      t.float :price
      t.text :description
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
