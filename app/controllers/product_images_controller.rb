class ProductImagesController < ApplicationController

  before_action :set_product_image, only: %i[ destroy ]

  def new
    product_id = params[:product_id]
    if product_id.blank? || product_id.to_i == 0
      render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
    else
      @product = Product.find(product_id)
      @image = @product.images.build
    end
  end

  def create
    @product = Product.find(params[:product_id])
    @image = @product.images.build(product_image_params)
    respond_to do |format|
      if (@product.images.length - 1) < 5
        if @image.save
          Image.save_image(params[:file_image], "product_images", @image.product_id, @image.image_url)
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
    Image.delete_image("product_images", @image.product_id, @image.image_url)
    @image.destroy!
    respond_to do |format|
      format.html { redirect_to edit_product_url(@image.product_id), notice: "Imagen eliminada." }
    end
  end

  private
    def set_product_image
      @image = ProductImage.find(params[:id])
    end
    def product_image_params
      parameters = params.require(:product_image).permit(:image_url, :product_id)
      product_id = params[:product_id]
      file = params[:file_image]
      parameters[:image_url] = Image.get_image_name(file, product_id) if !file.blank?
      parameters
    end

end
