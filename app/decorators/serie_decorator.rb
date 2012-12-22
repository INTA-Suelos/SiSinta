class SerieDecorator < ApplicationDecorator
  decorates :serie
  decorates_association :perfiles

  def nuevo_perfil
    PerfilDecorator.new(Perfil.new)
  end

  def to_s
    source.nombre
  end

end
