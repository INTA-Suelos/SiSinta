# encoding: utf-8
module GruposHelper
  def titulo_de_la_accion
    case params[:action]
      when 'index'
        'Subgrupos presentes en los perfiles'
      when 'show'
        "Subgrupo #{@grupo.descripcion}"
      when 'new'
        'Nuevo subgrupo'
      when 'edit'
        "Editando subgrupo #{@fase.descripcion}"
      else
        nil
    end
  end
end
