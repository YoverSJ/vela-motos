class Product < ApplicationRecord

  has_many :images, class_name: "ProductImage", foreign_key: "product_id", dependent: :destroy

  before_create :generate_sku

  validates :name, presence: true, uniqueness: true
  validates :warranty, :color , presence: true
  validates :price, :discount, :total_price, :stock, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :imagen, format: { with: /\.(jpg|jpeg|png)\z/i, message: 'debe ser un archivo de imagen válido (jpg, jpeg o png)' }, if: :imagen_present?

  private
    def imagen_present?
      imagen.present?
    end

    def generate_sku
      self.code = loop do
        random_sku = SecureRandom.hex(4).upcase # Genera un código hexadecimal aleatorio de 4 caracteres
        break random_sku unless Product.exists?(code: random_sku)
      end
    end


end
