# encoding: utf-8
module EquiposHelper
  include PaginacionHelper

  def titulo_de_la_accion
    case params[:action]
      when 'index'
        'Equipos de trabajo'
      when 'show'
        "Equipo #{@equipo.nombre}"
      when 'new'
        'Nuevo equipo'
      when 'edit'
        "Editando equipo #{@equipo.nombre}"
      when 'permisos'
        "Permisos para el equipo #{@recurso.nombre}"
      else
        nil
    end
  end
end
