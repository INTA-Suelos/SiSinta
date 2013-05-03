# encoding: utf-8
module BusquedasHelper
  def titulo_de_la_accion
    case params[:action]
      when 'index'
        'Tus búsquedas'
      when 'show'
        "Resultados de #{@busqueda.nombre}"
      when 'new'
        'Nueva búsqueda'
      when 'edit'
        "Modificar búsqueda #{@busqueda.nombre}"
      else
        nil
    end
  end
end
