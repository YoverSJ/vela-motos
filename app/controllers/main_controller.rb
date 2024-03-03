class MainController < ApplicationController

  def index
    @page_title = "GreenLote VelaMotos | Una De Las Primeras Empresas Que Operan Con Productos Eléctricos En El Perú"
  end

  def about_us
    @page_title = "Nosotros"
  end

  def catalog
    @products = Product.all
    @page_title = "Catalogo"
  end

  def contact
    @page_title = "Contacto"
  end

  def single_product
    @product = Product.find_by_name(params[:name].gsub("-", " "))
    @page_title = @product.name.capitalize
  end

end
