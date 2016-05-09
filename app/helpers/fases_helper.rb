# encoding: utf-8
module FasesHelper
  include PaginacionHelper

  def titulo_de_la_accion
    case params[:action]
    when 'index'
      'Fases'
    when 'show'
      "Fase #{@fase.codigo}"
    when 'new'
      'Nueva fase'
    when 'edit'
      "Editando fase #{@fase.codigo}"
    else
      nil
    end
  end
end
