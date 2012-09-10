class CalicataDecorator < Draper::Base
  decorates :calicata
  decorates_association :ubicacion

  def fecha
    calicata.fecha.to_s(:dma)
  end

  def etiquetas
    calicata.etiquetas.join(', ')
  end

  def reconocedores
    calicata.reconocedores.join(', ')
  end

end
