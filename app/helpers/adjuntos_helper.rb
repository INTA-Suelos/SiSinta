# encoding: utf-8
module AdjuntosHelper
  def titulo_de_la_accion
    case params[:action]
    when 'index'
      "Archivos adjuntos"
    when 'show'
      "Datos del adjunto"
    when 'new'
      "Subir adjunto"
    when 'edit'
      "Editando adjunto"
    else
      nil
    end
  end

  # FIXME Integrar en el contenido
  def subtitulo
    case params[:action]
      when 'index', 'new'
        "Para el perfil #{@perfil.numero}"
      when 'show', 'edit'
        @adjunto.archivo_file_name
      else
        nil
    end
  end
end
