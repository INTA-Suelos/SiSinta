# encoding: utf-8
module ProyectosHelper
  include PaginacionHelper

  def titulo_de_la_accion
    case params[:action]
      when 'index'
        'Proyectos'
      when 'show'
        @proyecto.nombre
      when 'new'
        'Nuevo proyecto'
      when 'edit'
        "Editando #{@proyecto.nombre}"
      else
        nil
    end
  end
end
