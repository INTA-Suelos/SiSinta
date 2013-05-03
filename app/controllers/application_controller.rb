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

    # Devuelve un csv en base a los atributos del modelo
    #
    # * *Args*    :
    #   - +coleccion+ -> coleccion a convertir en CSV
    #   - +nombre+ -> prefijo para el nombre del archivo +.csv+
    def procesar_csv(coleccion = [], prefijo = 'csv')
      @archivo = "#{prefijo}_#{Date.today.strftime('%Y-%m-%d')}.csv"

      @encabezado = true if params[:incluir_encabezado]

      @respuesta = CSV.generate(:headers => @encabezado) do |csv|
        @atributos = params[:atributos].try :sort

        csv << @atributos if @encabezado

        coleccion.each do |miembro|
          csv << miembro.to_array(@atributos)
        end
      end

      send_data @respuesta, :filename => @archivo
    end

    def direccion_de_ordenamiento
      %w[asc desc].include?(params[:direccion]) ? params[:direccion] : 'asc'
    end

    # Para los mensajes del flash de responders
    def interpolation_options
      { el_la: 'el' }
    end
end
