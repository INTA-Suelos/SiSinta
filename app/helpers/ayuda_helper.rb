# -*- encoding : utf-8 -*-
module AyudaHelper

  # Crea los divs preparados para el tooltip de los formularios, con la
  # descripción del campo.
  #
  # * *Args*    :
  #   - +campo+ -> El campo del que devolver la descripción.
  #   - +html+ -> Hash de opciones para el div. Se usa +clases+ para determinar
  #   la/las clase/s del +div+, que por default es +ayuda+, e +id+ para
  #   determinar el id, que por default es +ayuda_modelo_campo+
  # * *Returns* :
  #   - Un +div+ preparado con la clase 'ayuda'
  #
  def ayuda_para(campo, html = {})
    texto = Ayuda.find_by_campo(campo).try(:ayuda)
    id = html[:id] || "ayuda_#{campo.gsub('.', '_')}"
    clases = html[:clases] || 'ayuda'

    "<div id='#{id}' class='#{clases}'>#{texto}</div>".html_safe if texto
  end
end
