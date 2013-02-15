# encoding: utf-8
module UsuariosHelper
  include PaginacionHelper

  def titulo_de_la_accion
    case params[:action]
      when 'index'
        "Administración de usuarios y grupos"
      else
        nil
    end
  end
end
