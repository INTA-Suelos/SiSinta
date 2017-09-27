# Controlador base para todos los controladores que responden a clientes web.
require 'csv'
require 'application_responder'

class ApplicationController < ActionController::Base
  include BrowserDetect, ApplicationHelper

  # Responders
  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery

  # Antes que nada configurar el locale
  before_action :configurar_locale_para_request
  before_action :descubrir_browser
  before_action :agregar_parametros_permitidos, if: :devise_controller?
  before_action :preparar_busqueda_global

  def current_usuario
    super.try(:decorate)
  end

  def configurar_locale_para_request
    I18n.locale = elegir_locale(params[:locale])
  end

  # Define qué locale se va a usar en base al parámetro enviado si es uno de
  # los locales soportados. En caso contrario, usar el preferido del usuario,
  # si tiene.
  def elegir_locale(locale)
    locale_sanitizado = I18n.available_locales.map(&:to_s).include?(locale) ? locale : nil

    locale_sanitizado || current_usuario.try(:idioma) || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end

  # Completa variables de instancia para usar en las vistas con información sobre el navegador de la
  # solicitud.
  def descubrir_browser
    @ie = browser_is?('ie')
    @mobile = browser_is_mobile?
  end

  # Métodos que necesitamos en las vistas
  helper_method :direccion_de_ordenamiento, :metodo_de_ordenamiento, :ayuda_para, :volver
  # Los específicos de BrowserDetect
  helper_method :browser_is?, :browser_webkit_version, :ua, :browser_is_mobile?

  protected

    # Redirije hacia atrás o en caso de no exister, vuelve al inicio.
    # ActiveAdmin lo llama con el error apropiado
    def volver(error = nil)
      begin
        redirect_to :back, alert: error.try(:message)
      rescue ActionController::RedirectBackError
        redirect_to :root, alert: error.try(:message)
      end
    end

    def agregar_parametros_permitidos
      devise_parameter_sanitizer.permit :account_update, keys: [:nombre]
      devise_parameter_sanitizer.permit :sign_up, keys: [:nombre, :idioma]
    end

    def direccion_de_ordenamiento
      %w[asc desc].include?(params[:direccion]) ? params[:direccion] : 'asc'
    end

    # La ficha o plantilla de carga que seleccionó el usuario en la acción
    # anterior. Si no hay, se usa la que definió en su perfil de usuario. Si no
    # hay usuario, usamos la default
    def seleccionar_ficha
      @ficha = begin
        Ficha.find session[:ficha]
      rescue ActiveRecord::RecordNotFound
        current_usuario.try(:ficha) || Ficha.default
      end
    end

    # Inicializa el objeto a usar en la búsqueda de la barra de navegación
    def preparar_busqueda_global
      @busqueda_global = Perfil.search
    end
end
