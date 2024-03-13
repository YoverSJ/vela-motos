class AccessoryImagesController < ApplicationController

  before_action :set_accessory_image, only: %i[ destroy ]

  def new
    @page_title = "Nueva Imagen"
    accessory_id = params[:accessory_id]
    if accessory_id.blank? || accessory_id.to_i == 0
      render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
    else
      @accessory = Accessory.find(accessory_id)
      @image = @accessory.images.build
    end
  end

  def create
    @page_title = "Nueva Imagen"
    @accessory = Accessory.find(params[:accessory_id])
    @image = @accessory.images.build(accessory_image_params)
    respond_to do |format|
      if (@accessory.images.length - 1) < 5
        if @image.save
          #Image.save_image(params[:file_image], "accessory_images", @image.accessory_id, @image.image_name)
          cloudinary_upload = Image.upload_image_to_cloudinary(params[:file_image], "accessory_images", @accessory.code, @image.image_name)
          @image.update(image_url: cloudinary_upload['secure_url'])
          format.html { redirect_to edit_accessory_url(@image.accessory_id), notice: "Imagen agregada." }
        else
          format.html { render :new, status: :unprocessable_entity }
        end
      else
        @image.errors.add(:accessory_id, "no puede tener mas de 5 imagenes")
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    #Image.delete_image("accessory_images", @image.accessory_id, @image.image_name)
    Image.delete_image_from_cloudinary("accessory_images", @image.accessory.code, @image.image_name)
    delete_main_accessory_photo(@image.image_url, @image.accessory.imagen)
    @image.destroy!
    respond_to do |format|
      format.html { redirect_to edit_accessory_url(@image.accessory_id), notice: "Imagen eliminada." }
    end
  end

  private
    def set_accessory_image
      @image = AccessoryImage.find(params[:id])
    end
    def accessory_image_params
      parameters = params.require(:accessory_image).permit(:image_name, :image_url, :accessory_id)
      accessory_id = params[:accessory_id]
      file = params[:file_image]
      parameters[:image_name] = Image.get_image_name(file, Accessory.all, accessory_id) if !file.blank?
      parameters
    end

    def delete_main_accessory_photo(photo, main_photo)
      if photo == main_photo
        @image.accessory.update(imagen: nil)
      end
    end

end
