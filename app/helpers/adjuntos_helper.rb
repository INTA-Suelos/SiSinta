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
end
