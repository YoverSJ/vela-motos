class AddImageNameToProductImages < ActiveRecord::Migration[7.1]
  def change
    add_column :product_images, :image_name, :string
  end
end
