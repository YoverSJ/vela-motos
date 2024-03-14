# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  # GET /resource/password/new
  def new
    @page_title = "Recuperar contraseña"
    super
  end

  # POST /resource/password
  def create
    @page_title = "Recuperar contraseña"
    super
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    @page_title = "Restablecer contraseña"
    super
  end

  # PUT /resource/password
  def update
    @page_title = "Restablecer contraseña"
    super
  end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
