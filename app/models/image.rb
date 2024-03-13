class Image

  def self.get_image_name(file, model, product_id)
    image_name = nil
    if !file.blank?
      product = product = model.find(product_id)
      images = product.images
      file_name = file.original_filename
      extension = File.extname(file_name)
      image_name = product.name.downcase.gsub(" ", "_") + "_" + (images.length + 1).to_s + extension
    end
    return image_name
  end

  def self.save_image(image, model_type, model_id, image_name)
    if !image.blank?
      # Definimos la ruta donde guardaremos la imagen dentro del proyecto
      directory = Rails.root.join('public', 'uploads', model_type.to_s, model_id.to_s)
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

  def self.delete_image(model_type, model_id, image_name)
    #Construimos la ruta donde esta ubicada la imagen
    directory = Rails.root.join('public', 'uploads', model_type.to_s, model_id.to_s)
    #Concantenamos el nombre de la imagen con la ruta
    image_path = directory.join(image_name)
    #Eliminamos si la imagen ya existe
    if File.exist?(image_path.to_s)
      File.delete(image_path.to_s)
    end
  end

  def self.upload_image_to_cloudinary(file_image, model_type, model_id, image_name)
    cloudinary_upload = nil
    if !file_image.blank?
      # Obtenemos el nombre de la imagen sin la extension
      image_name = File.basename(image_name, '.*')
      # Carpeta en Cloudinary donde deseas guardar la imagen
      folder = "uploads/#{model_type}/#{model_id}"
      # Construimos el nombre del archivo con la carpeta
      # uploaded_name = File.join(folder, image_name)
      # Subimos la imagen a Cloudinary con el nombre personalizado y la carpeta especificada
      cloudinary_upload = Cloudinary::Uploader.upload(file_image.tempfile, folder: folder, public_id: image_name)
      return cloudinary_upload
    else
      return cloudinary_upload
    end
  end

  def self.delete_image_from_cloudinary(model_type, model_id, image_name)
    # Obtenemos el nombre de la imagen sin la extension
    image_name = File.basename(image_name, '.*')
    # Extrae el ID público de la imagen de Cloudinary
    folder = "uploads/#{model_type}/#{model_id}/#{image_name}"
    # Elimina la imagen de Cloudinary
    Cloudinary::Uploader.destroy(folder)
  end

end
