class AccessoriesController < ApplicationController

  before_action :set_data_select, only: %i[ new create edit update]
  before_action :set_accessory, only: %i[ show edit update destroy ]

  # GET /accessories or /accessories.json
  def index
    if params[:page].is_a?(String) && params[:page].to_i < 1
      render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
    else
      @page_title = "Accesorios"
      @pagy, @accessories = pagy(Accessory.all.order("updated_at DESC"), items: 10)
    end
  end

  # GET /accessories/1 or /accessories/1.json
  def show
    @page_title = "Detalles del accesorio"
    @colors = get_colors(@accessory.color)
    @images = @accessory.images
    @photos = get_photos(@images)
    @categories = Category::ACCESSORY_CATEGORY
  end

  # GET /accessories/new
  def new
    @page_title = "Nuevo accesorio"
    @accessory = Accessory.new
    @images = @accessory.images
  end

  # GET /accessories/1/edit
  def edit
    @page_title = "Editar accesorio"
    @images = @accessory.images
    @photos = get_photos(@images)
  end

  # POST /accessories or /accessories.json
  def create
    @page_title = "Nuevo accesorio"
    @accessory = Accessory.new(accessory_params)
    @images = @accessory.images
    respond_to do |format|
      if @accessory.save
        format.html { redirect_to accessory_url(@accessory), notice: "Accesorio creado." }
        format.json { render :show, status: :created, location: @accessory }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @accessory.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accessories/1 or /accessories/1.json
  def update
    @page_title = "Editar accesorio"
    @images = @accessory.images
    respond_to do |format|
      if @accessory.update(accessory_params)
        format.html { redirect_to accessory_url(@accessory), notice: "Accesorio actualizado." }
        format.json { render :show, status: :ok, location: @accessory }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @accessory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accessories/1 or /accessories/1.json
  def destroy
    @accessory.destroy!
    respond_to do |format|
      format.html { redirect_to accessories_url, notice: "Accesorio eliminado." }
      format.json { head :no_content }
    end
  end

  def show_accessory
    @accessory = Accessory.find(params[:id])
    @colors = get_colors(@accessory.color)
    respond_to do |format|
      format.html
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_accessory
      @accessory = Accessory.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def accessory_params
      parameters = params.require(:accessory).permit(:code, :name, :description, :category, :warranty, :color, :price, :discount, :total_price, :stock, :imagen)
      parameters[:name] = parameters[:name].strip
      parameters
    end

    def set_data_select
      @colors = COLORS
      @categories = Category::ACCESSORY_CATEGORY
    end

    def get_photos(photos)
      photos_hash = {}
      photos.each_with_index do |photo, index|
        photos_hash.store("Foto #{index+1}", photo.image_url)
      end
      return photos_hash
    end
end
