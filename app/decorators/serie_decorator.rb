# encoding: utf-8
class SerieDecorator < ApplicationDecorator
  decorates_association :perfiles, with: PaginadorDecorator

  def to_s
    source.nombre
  end

  def nombre_y_simbolo
    source.nombre + (source.simbolo? ? " (#{source.simbolo})" : '')
  end
end
