# encoding: utf-8
class UsuarioDecorator < ApplicationDecorator
  decorates_association :perfiles, with: PaginadorDecorator

  def to_s
    source.nombre
  end
end
