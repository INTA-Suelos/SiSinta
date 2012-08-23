class CalicataDecorator < Draper::Base
  decorates :calicata
  decorates_association :ubicacion

  def etiquetas
    calicata.etiquetas.join(', ')
  end

  def reconocedores
    calicata.reconocedores.join(', ')
  end

end
