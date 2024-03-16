class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include Pagy::Backend

  COLORS = {
    "Blanco": "white",
    "Platino": "silver",
    "Negro": "black",
    "Rojo": "red",
    "Naranja": "orange",
    "Marrón": "brown",
    "Amarillo": "yellow",
    "Oliva": "olive",
    "Lima": "lime",
    "Verde": "green",
    "Aqua": "aqua",
    "Turquesa": "turquoise",
    "Azul": "blue",
    "Marino": "navy",
    "Fucsia": "fuchsia",
    "Morado": "purple",
    "Gris": "gray",
    "Rojo Oscuro": "darkred",
    "Coral": "coral",
    "Dorado": "gold",
    "Azul Cielo": "skyblue",
    "Violeta": "violet",
    "Rosado": "pink",
  }

  def get_colors(colores)
    colors = []
    array_color = colores.split(",")
    array_color.each do |color|
      result = COLORS.select { |k, v| v == color }
      colors << result
    end
    return colors
  end

  private
    def authenticate_admin!
      unless current_user && current_user.has_role?('admin')
        flash[:alert] = "Acceso denegado. Debes ser un administrador para realizar esta acción."
        redirect_to root_path
      end
    end

end
