class ProductsController < ApplicationController

  before_action :set_data_select, only: %i[ new create edit ]
  before_action :set_product, only: %i[ show edit update destroy ]

  # GET /products or /products.json
  def index
    @products = Product.all
    @page_title = "Productos"
  end

  # GET /products/1 or /products/1.json
  def show
    @page_title = "Detalles del producto"
    @colors = get_colors(@product.color)
    @images = @product.images
    @photos = get_photos(@images)
  end

  # GET /products/new
  def new
    @product = Product.new
    @images = @product.images
    @page_title = "Nuevo producto"
  end

  # GET /products/1/edit
  def edit
    @page_title = "Editar producto"
    @images = @product.images
    @photos = get_photos(@images)
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)
    respond_to do |format|
      if @product.save
        format.html { redirect_to product_url(@product), notice: "Producto creado." }
        format.json { render :show, status: :created, location: @product }
      else
        @product.imagen = nil
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to product_url(@product), notice: "Producto actualizado." }
        format.json { render :show, status: :ok, location: @product }
      else
        fProduct = Product.find_by_id(@product.id)
        @product.imagen = fProduct.imagen
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy!
    respond_to do |format|
      format.html { redirect_to products_url, notice: "Producto eliminado." }
      format.json { head :no_content }
    end
  end

  def show_product
    @product = Product.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      parameters = params.require(:product).permit(:name, :description, :color, :price, :discount, :total_price, :stock, :code, :imagen, :warranty)
    end

    def set_data_select
      @colors = COLORS
    end

    def get_photos(photos)
      photos_hash = {}
      photos.each_with_index do |photo, index|
        photos_hash.store("Foto #{index+1}", photo.image_url)
      end
      return photos_hash
    end

end
