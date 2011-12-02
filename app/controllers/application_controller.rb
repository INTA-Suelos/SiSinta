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
    # Uso ARel porque me permite ignorar que el LIKE es case-sensitive en PostgreSQL pero
    # insensitive en otros motores. En PostgreSQL se usa ILIKE
    # para comparaciones case-insensitive (es una extensión exclusiva de PostgreSQL
    if params[:term]
      conjunto = modelo.where modelo.arel_table[atributo].matches("%#{params[:term]}%")
    else
      conjunto = modelo.all
    end
    lista = conjunto.map {|elemento| Hash[:id => elemento.id,
                                          :label => elemento.send(atributo),
                                          "#{atributo}" => elemento.send(atributo)]}
  end

  # Métodos de BrowserDetect
  helper_method :browser_is?, :browser_webkit_version, :ua, :browser_is_mobile?
end
