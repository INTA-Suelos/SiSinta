# encoding: utf-8
module AdjuntosHelper
  def icono_para_extension(ext)
    archivo = "iconos/file_extension_#{ext}.png"

    if File.exists? "app/assets/images/#{archivo}"
      image_tag archivo, alt: ext
    else
      ".#{ext}"
    end
  end

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
