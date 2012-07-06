# encoding: utf-8
class AutorizadoController < ApplicationController

  # Autenticación con Devise
  before_filter :authenticate_usuario!

  rescue_from CanCan::AccessDenied do |e|
    flash[:error] = I18n.t 'unauthorized.default'
    begin
      redirect_to :back
    rescue ActionController::RedirectBackError
      redirect_to :root
    end
  end

  # Autorización con CanCan
  check_authorization
  authorize_resource

end
