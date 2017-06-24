# encoding: utf-8
class UsuarioDecorator < ApplicationDecorator
  decorates_association :perfiles, with: PaginadorDecorator

  def to_s
    source.nombre
  end

  def to_opcion
    [ "#{source.nombre} - #{source.email}" , source.id ]
  end

  # Forma identificadores tipo "nombre (email)"
  def nombre_y_mail
    resultado = [object.nombre]
    resultado << ' (' if object.nombre
    resultado << object.email
    resultado << ')' if object.nombre

    resultado.join
  end
end
