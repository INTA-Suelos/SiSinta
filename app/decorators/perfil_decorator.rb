# encoding: utf-8
class PerfilDecorator < ApplicationDecorator
  decorates_association :ubicacion
  decorates_association :serie
  decorates_association :proyecto
  decorates_association :fase

  def fecha
    source.fecha.try :to_s, :dma
  end

  def etiquetas
    source.etiquetas.join(', ')
  end

  def reconocedores
    source.reconocedores.join(', ')
  end

  def to_s
    source.numero || source.nombre
  end
end
