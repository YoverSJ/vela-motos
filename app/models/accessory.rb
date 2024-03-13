class Accessory < ApplicationRecord

  has_many :images, class_name: "AccessoryImage", foreign_key: "accessory_id", dependent: :destroy

  before_create :generate_sku

  validates :name, presence: true, uniqueness: true
  validates :category, :warranty, :color, presence: true
  validates :price, :discount, :total_price, :stock, presence: true, numericality: { greater_than_or_equal_to: 0 }

  private
    def generate_sku
      self.code = loop do
        random_sku = SecureRandom.hex(4).upcase # Genera un código hexadecimal aleatorio de 4 caracteres
        break random_sku unless Product.exists?(code: random_sku)
      end
    end

end
