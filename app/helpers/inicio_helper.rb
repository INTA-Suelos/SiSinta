# encoding: utf-8
module InicioHelper
  def titulo_de_la_accion
    case params[:action]
      when 'index'
        'Sistema de información de Suelos del INTA'
      else
        nil
    end
  end
end
