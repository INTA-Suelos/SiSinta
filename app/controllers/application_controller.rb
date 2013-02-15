# encoding: utf-8
require 'csv'
require "application_responder"

class ApplicationController < ActionController::Base
  include BrowserDetect, ApplicationHelper

  # Responders
  self.responder = ApplicationResponder
  respond_to :html
  respond_to :json, only: :autocompletar

  protect_from_forgery

  before_filter :descubrir_browser

  # CanCan necesita un método *current_user* y Devise genera la función
  # en base al nombre del modelo, que en nuestro caso es Usuario
  def current_user
    current_usuario
  end

  # Completa variables de instancia para usar en las vistas con información sobre el navegador de la
  # solicitud.
  #
  def descubrir_browser
    @ie = browser_is?('ie')
    @mobile = browser_is_mobile?
  end

  # GET /:controlador/autocompletar/:atributo
  def autocompletar(modelo, atributo)
    render json: lista_para_autocompletar(modelo, atributo)
  end

  # Transforma la colección +objetos+ en una lista de 'features' de GeoJSON.
  #
  # * *Args*    :
  #   - +objetos+ -> La colección de objetos a transformar
  #   - +metodo_geom+ -> El método que invocar en cada miembro de +objetos+ que
  #   determinará su geometría.
  # * *Returns* :
  #   - La lista de objetos en formato de features de la especificación GeoJSON.
  #
  def como_geojson(objetos, metodo_geom)
    factory = RGeo::GeoJSON::EntityFactory.instance

    features = []
    objetos.each do |o|
      features << factory.feature(o.send(metodo_geom), nil, o.propiedades_publicas)
    end

    RGeo::GeoJSON.encode factory.feature_collection(features)
  end

  # GET /:controlador/:id/permisos
  def permisos
    @titulo = "Permisos"
    @recurso = recurso
    @controlador = params[:controller]
    @miembros = Usuario.miembros(@recurso).collect {|u| u.id}
    @usuarios = Usuario.all
    @recurso = @recurso.decorate
    render 'comunes/permisos'
  end

  # POST /:controlador/:id/permitir
  def permitir
    @recurso = recurso

    respond_to do |format|
      if Usuario.find(params["usuario_ids"]).each { |u| u.grant :miembro, @recurso }
        format.html { redirect_to permisos_url,
                      notice: I18n.t('messages.updated', model: @recurso.class) }
        format.json { head :ok }
      else
        format.html { render action: "permisos" }
        format.json { render json: @recurso.errors, status: :unprocessable_entity }
      end
    end
  end

  # Métodos de BrowserDetect
  helper_method :browser_is?, :browser_webkit_version, :ua, :browser_is_mobile?

  # Ayuda para todos
  helper_method :ayuda_para

  # Para ordenar las columnas
  helper_method :direccion_de_ordenamiento, :metodo_de_ordenamiento

  # Para los permisos
  helper_method :permitir_url

  protected

    # Devuelve una lista de coincidencias con el término de búsqueda para usar en el autocomplete de
    # JQuery-UI. Cada controlador llama al método con un Modelo
    #
    # * *Args*    :
    #   - +modelo+ -> La clase del modelo sobre el que hacer la búsqueda
    #   - +atributo+ -> El atributo que buscar, como cadena o símbolo
    # * *Returns* :
    #   - La lista de coincidencias mapeada en +json+
    #
    def lista_para_autocompletar(modelo, atributo)
      # Uso ARel porque me permite ignorar que el LIKE es case-sensitive en
      # PostgreSQL pero insensitive en otros motores. En PostgreSQL se usa ILIKE
      # para comparaciones case-insensitive (es una extensión exclusiva de
      # PostgreSQL)
      if params[:term]
        conjunto = modelo.where modelo.arel_table[atributo].matches("%#{params[:term]}%")
      else
        conjunto = modelo.all
      end
      lista = conjunto.map {|elemento| Hash[:id => elemento.id,
                                            :label => elemento.send(atributo),
                                            "#{atributo}" => elemento.send(atributo)]}
    end

    # Carga el perfil al que pertenece el modelo anidado
    def cargar_perfil
      @perfil = Perfil.find(params[:perfil_id])
    end

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

    # TODO filtrar por modelos existentes
    def recurso
      Kernel.const_get(params[:controller].classify).find(params[:id])
    end

    def permisos_url
      "#{url_for(@recurso)}/permisos"
    end

    def permitir_url
      "#{url_for(@recurso)}/permitir"
    end
end
