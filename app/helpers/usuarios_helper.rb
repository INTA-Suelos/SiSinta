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

  def roles_globales(seleccionado)
    options_for_select [  ['Administrador', 'Administrador' ],
                          ['Autorizado',    'Autorizado'    ] ], seleccionado
  end
end
