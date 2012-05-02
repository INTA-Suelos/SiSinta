# -*- encoding : utf-8 -*-
module AdjuntosHelper
  def icono_para_extension(ext)
    image_tag("iconos/file_extension_#{ext}.png", alt: ext)
  end
end
