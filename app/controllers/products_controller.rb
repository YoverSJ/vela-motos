class ProductsController < ApplicationController
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
  end

  # GET /products/new
  def new
    @product = Product.new
    @page_title = "Nuevo producto"
    @colors = COLORS
  end

  # GET /products/1/edit
  def edit
    @page_title = "Editar producto"
    @colors = COLORS
    @images = @product.images
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)
    image = params[:file_image]
    image_name =  @product.imagen
    @colors = COLORS
    respond_to do |format|
      if @product.save
        save_image(image, image_name)
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
    image = params[:file_image]
    image_name =  product_params[:imagen]
    respond_to do |format|
      if @product.update(product_params)
        save_image(image, image_name)
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
      product_name = parameters[:name]
      file = params[:file_image]
      parameters[:imagen] = get_image_name(file, product_name) if !file.blank?
      parameters
    end

    def get_image_name(file, product_name)
      image_name = nil
      if !file.blank?
        file_name = file.original_filename
        extension = File.extname(file_name)
        image_name = product_name.downcase.gsub(" ", "_") + extension
      end
      return image_name
    end

    def save_image(image, image_name)
      if !image.blank?
        # Definimos la ruta donde guardaremos la imagen dentro del proyecto
        directory = Rails.root.join('public', 'product_images')
        # Verificamos que el directorio exista, si no, lo creamos
        FileUtils.mkdir_p(directory) unless File.directory?(directory)
        # Concantenamos el nombre de la imagen con la ruta
        file = directory.join(image_name)
        #Eliminamos si la imagen ya existe
        if File.exist?(file.to_s)
          File.delete(file.to_s)
        end
        # Guardamos la imagen en el directorio
        File.open(File.join(directory, image_name), 'wb') do |file|
          file.write(image.read)
        end
      end
    end

end
