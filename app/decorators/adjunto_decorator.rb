# encoding: utf-8
class AdjuntoDecorator < ApplicationDecorator
  decorates_association :perfil

  def to_s
    source.archivo_file_name
  end

  def icono
    ext = source.extension
    archivo = "iconos/file_extension_#{ext}.png"
    if File.exists? "app/assets/images/#{archivo}"
      h.image_tag archivo, alt: ext
    elsif ext.present?
      ".#{ext}"
    else
      ''
    end
  end
end
