json.extract! product, :id, :name, :description, :color, :price, :discount, :total_price, :stock, :code, :imagen, :warranty, :created_at, :updated_at
json.url product_url(product, format: :json)
