class SerieDecorator < ApplicationDecorator
  decorates :serie
  decorates_association :perfiles

  def to_s
    source.nombre
  end

  def nombre_y_simbolo
    source.nombre + (source.simbolo? ? " (#{source.simbolo})" : '')
  end
end
