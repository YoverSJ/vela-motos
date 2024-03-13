class CreateAccessories < ActiveRecord::Migration[7.1]
  def change
    create_table :accessories do |t|
      t.string :code
      t.string :name
      t.text :description
      t.string :category
      t.string :warranty
      t.string :color
      t.decimal :price
      t.integer :discount
      t.decimal :total_price
      t.integer :stock
      t.string :imagen

      t.timestamps
    end
  end
end
