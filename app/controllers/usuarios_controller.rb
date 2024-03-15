class UsuariosController < ApplicationController

  before_action :authenticate_user!
  before_action :set_user, only: %i[ show edit update destroy ]

  def index
    if params[:page].is_a?(String) && params[:page].to_i < 1
      render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
    else
      @page_title = "Usuarios"
      @pagy, @users = pagy(User.all.order("updated_at DESC"), items: 10)
    end
  end

  def new
    @page_title = "Registrar usuario"
    @user = User.new
  end

  def create
    @page_title = "Registrar usuario"
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to usuario_url(@user), notice: "Usuario creado." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def show
    @page_title = "Detalles del usuario"
  end

  def edit
    @page_title = "Editar usuario"
  end

  def update
    @page_title = "Editar usuario"
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to usuario_url(@user), notice: "Usuario actualizado." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy!
    respond_to do |format|
      format.html { redirect_to usuarios_url, notice: "Usuario eliminado." }
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :username, :email, :password, :password_confirmation)
    end

end
