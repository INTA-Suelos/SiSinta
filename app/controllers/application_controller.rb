# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  include BrowserDetect

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
  def autocompletar(modelo)
    render json: lista_para_autocompletar(modelo, params[:atributo])
  end

  #
  #
  # * *Args*    :
  #   - ++ ->
  # * *Returns* :
  #   -
  # * *Raises* :
  #   - ++ ->
  #
  def como_geojson(objetos, metodo_geom)
    factory = RGeo::GeoJSON::EntityFactory.instance

    features = []
    objetos.each do |o|
      features << factory.feature(o.send(metodo_geom), nil, o.propiedades_publicas)
    end

    RGeo::GeoJSON.encode factory.feature_collection(features)
  end

  # Métodos de BrowserDetect
  helper_method :browser_is?, :browser_webkit_version, :ua, :browser_is_mobile?

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

  # Carga la calicata a la que pertenecen el modelo anidado
  #
  def cargar_calicata
    @calicata = Calicata.find(params[:calicata_id])
  end

  # Devuelve un csv en base a los atributos del modelo
  #
  # * *Args*    :
  #   - +coleccion+ -> coleccion a convertir en CSV
  #   - +nombre+ -> prefijo para el nombre del archivo +.csv+
  # * *Returns* :
  #   - La lista de coincidencias mapeada en +json+

  def procesar_csv(coleccion = {}, prefijo = 'csv')

    @archivo = "#{prefijo}_#{Date.today.strftime('%Y-%m-%d')}.csv"

    @encabezado = true if params[:incluir_encabezado]

    @respuesta = CSV.generate(:headers => @encabezado) do |csv|
      @atributos = params[:atributos].keys.sort

      csv << @atributos if @encabezado

      coleccion.each do |miembro|
        csv << miembro.como_arreglo(@atributos)
      end
    end

    send_data @respuesta, :filename => @archivo

  end

end
