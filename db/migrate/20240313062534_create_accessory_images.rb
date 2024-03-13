class CreateAccessoryImages < ActiveRecord::Migration[7.1]
  def change
    create_table :accessory_images do |t|
      t.string :image_name
      t.string :image_url
      t.references :accessory, null: false, foreign_key: true

      t.timestamps
    end
  end
end
