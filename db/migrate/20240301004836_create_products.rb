class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.string :color
      t.decimal :price
      t.integer :discount
      t.decimal :total_price
      t.integer :stock
      t.string :code
      t.string :imagen
      t.string :warranty

      t.timestamps
    end
  end
end
