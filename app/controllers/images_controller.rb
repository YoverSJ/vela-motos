class ImagesController < ApplicationController

  before_action :set_image, only: %i[ destroy ]

  def new
    @image = Image.new
    @product_id = params[:product_id]
    if @product_id.blank? || @product_id.to_i == 0
      render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
    end
  end

  # POST /images or /images.json
  def create
    product_id = params[:image][:product_id]
    @product = Product.find(product_id)
    @image = Image.new(image_params)
    file_image = params[:file_image]
    image_name =  @image.image_url
    @product_id = @image.product_id
    respond_to do |format|
      if @product.images.length < 5
        if @image.save
          save_image(file_image, image_name)
          format.html { redirect_to edit_product_url(@image.product_id), notice: "Imagen agregada." }
        else
          format.html { render :new, status: :unprocessable_entity }
        end
      else
        @image.errors.add(:product_id, "no puede tener mas de 5 imagenes")
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @image.destroy!
    respond_to do |format|
      format.html { redirect_to edit_product_url(@image.product_id), notice: "Imagen eliminada." }
    end
  end

  private
    def set_image
      @image = Image.find(params[:id])
    end
    def image_params
      parameters = params.require(:image).permit(:image_url, :product_id)
      product_id = params[:image][:product_id]
      file = params[:file_image]
      parameters[:image_url] = get_image_name(file, product_id) if !file.blank?
      parameters
    end

    def get_image_name(file, product_id)
      image_name = nil
      if !file.blank?
        product = product = Product.find(product_id)
        product_images = product.images
        file_name = file.original_filename
        extension = File.extname(file_name)
        image_name = product.name.downcase.gsub(" ", "_") + "_" + (product_images.length + 1).to_s + extension
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
