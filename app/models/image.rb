class Image

  def self.get_image_name(file, product_id)
    image_name = nil
    if !file.blank?
      product = product = Product.find(product_id)
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

end
