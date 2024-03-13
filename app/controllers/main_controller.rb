class MainController < ApplicationController

  def index
    @page_title = "GreenLote VelaMotos | Una De Las Primeras Empresas Que Operan Con Productos Eléctricos En El Perú"
    @products = Product.where(id: get_random_products(Product.all, 0, 8))
    @accessories = Accessory.where(id: get_random_products(Accessory.all, 0, 6))
  end

  def about_us
    @page_title = "Nosotros"
  end

  def electric_motorcycles_catalog
    if params[:page].is_a?(String) && params[:page].to_i < 1
      render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
    else
      @page_title = "Motos Eléctricas"
      @categories = Category::PRODUCT_CATEGORY
      @colors = COLORS
      if !params[:category].blank? && params[:color].blank?
        @pagy, @products = pagy(Product.where(category: params[:category]), items: 9)
      elsif !params[:color].blank? && params[:category].blank?
        @pagy, @products = pagy(Product.where("color like ?", "%#{params[:color]}%"), items: 9)
      elsif !params[:category].blank? && !params[:color].blank?
        @pagy, @products = pagy(Product.where(category: params[:category]).where("color like ?", "%#{params[:color]}%"), items: 9)
      else
        @pagy, @products = pagy(Product.all, items: 9)
      end
    end
  end

  def accessories_catalog
    if params[:page].is_a?(String) && params[:page].to_i < 1
      render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
    else
      @page_title = "Accesorios"
      @categories = Category::ACCESSORY_CATEGORY
      @colors = COLORS
      if !params[:category].blank? && params[:color].blank?
        @pagy, @accessories = pagy(Accessory.where(category: params[:category]), items: 9)
      elsif !params[:color].blank? && params[:category].blank?
        @pagy, @accessories = pagy(Accessory.where("color like ?", "%#{params[:color]}%"), items: 9)
      elsif !params[:category].blank? && !params[:color].blank?
        @pagy, @accessories = pagy(Accessory.where(category: params[:category]).where("color like ?", "%#{params[:color]}%"), items: 9)
      else
        @pagy, @accessories = pagy(Accessory.all, items: 9)
      end
    end
  end

  def contact
    @page_title = "Contacto"
  end

  def single_product_electric_motorcycles
    @product = Product.find_by("LOWER(name) = ?", params[:name].gsub("-", " "))
    if @product.blank?
      render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
    else
      @page_title = @product.name.capitalize
      @colors = get_colors(@product.color)
      @related_products = Product.where(id: get_random_products(Product.all, @product.id, 6))
    end
  end

  def single_product_accessories
    @accessory = Accessory.find_by("LOWER(name) = ?", params[:name].gsub("-", " "))
    if @accessory.blank?
      render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
    else
      @page_title = @accessory.name.capitalize
      @colors = get_colors(@accessory.color)
      @related_accessories = Accessory.where(id: get_random_products(Accessory.all, @accessory.id, 6))
    end
  end

  private
    def get_random_products(products, product_id, quantity)
      product_ids = products.pluck(:id) - [product_id]
      random_products = product_ids.shuffle.take(quantity)
    end

end
