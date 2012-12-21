class SerieDecorator < Draper::Base
  decorates :serie
  decorates_association :perfiles

  def nuevo_perfil
    PerfilDecorator.new(Perfil.new)
  end

  def to_s
    source.nombre
  end

  def nombre_y_simbolo
    source.nombre + (source.simbolo? ? " (#{source.simbolo})" : '')
  end
end
