# encoding: utf-8
module SeriesHelper
  include PaginacionHelper

  def titulo_de_la_accion
    case params[:action]
    when 'index'
      'Series de suelos'
    when 'show'
      "Serie #{@serie.nombre_y_simbolo}"
    when 'new'
      'Nueva serie'
    when 'edit'
      "Editando serie #{@serie.nombre_y_simbolo}"
    when 'permisos'
      "Permisos para la serie #{@recurso.nombre_y_simbolo}"
    else
      nil
    end
  end
end
