class MainController < ApplicationController

  def index
    @page_title = "GreenLote VelaMotos | Una De Las Primeras Empresas Que Operan Con Productos Eléctricos En El Perú"
  end

  def about_us
    @page_title = "Nosotros"
  end

  def catalog
    if params[:page].is_a?(String) && params[:page].to_i < 1
      render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
    else
      @page_title = "Catalogo"
      @categories = Category::PRODUCT_CATEGORY
      @colors = COLORS
      ap params
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

  def contact
    @page_title = "Contacto"
  end

  def single_product
    @product = Product.find_by("LOWER(name) = ?", params[:name].gsub("-", " "))
    if @product.blank?
      render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
    else
      @page_title = @product.name.capitalize
      @colors = get_colors(@product.color)
      @related_products = Product.where(id: get_random_products(@product.id))
    end
  end

  private
    def get_random_products(product_id)
      product_ids = Product.all.pluck(:id) - [product_id]
      random_products = product_ids.shuffle.take(6)
    end

end
