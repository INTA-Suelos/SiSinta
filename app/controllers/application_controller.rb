# encoding: utf-8
require 'csv'
require "application_responder"

class ApplicationController < ActionController::Base
  include BrowserDetect, ApplicationHelper

  # Responders
  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery

  before_filter :descubrir_browser
  before_filter :agregar_parametros_permitidos, if: :devise_controller?

  # CanCan necesita un método *current_user* y Devise genera la función
  # en base al nombre del modelo, que en nuestro caso es Usuario
  def current_usuario
    super.try(:decorate)
  end
  def current_user
    self.current_usuario
  end

  # Completa variables de instancia para usar en las vistas con información sobre el navegador de la
  # solicitud.
  #
  def descubrir_browser
    @ie = browser_is?('ie')
    @mobile = browser_is_mobile?
  end

  # Métodos de BrowserDetect
  helper_method :browser_is?, :browser_webkit_version, :ua, :browser_is_mobile?

  # Ayuda para todos
  helper_method :ayuda_para

  # Para ordenar las columnas
  helper_method :direccion_de_ordenamiento, :metodo_de_ordenamiento

  protected

    def agregar_parametros_permitidos
      devise_parameter_sanitizer.for(:account_update) << [
        :nombre ]
      devise_parameter_sanitizer.for(:sign_up) << [
        :nombre ]
    end

    def direccion_de_ordenamiento
      %w[asc desc].include?(params[:direccion]) ? params[:direccion] : 'asc'
    end

    # Para los mensajes del flash de responders
    def interpolation_options
      { el_la: 'el' }
    end
end
