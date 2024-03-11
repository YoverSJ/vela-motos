class ProductImage < ApplicationRecord

  belongs_to :product

  validates :image_name, presence: true, format: { with: /\.(jpg|jpeg|png)\z/i, message: 'debe ser un archivo de imagen válido (jpg, jpeg o png)' }, if: :imagen_present?

  private
    def imagen_present?
      image_name.present?
    end

end
