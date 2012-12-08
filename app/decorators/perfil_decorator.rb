class PerfilDecorator < Draper::Base
  decorates :perfil
  decorates_association :ubicacion

  def fecha
    source.fecha.try :to_s, :dma
  end

  def etiquetas
    source.etiquetas.join(', ')
  end

  def reconocedores
    source.reconocedores.join(', ')
  end

  def numero
    source.numero || '-'
  end

end
