class PerfilDecorator < Draper::Base
  decorates :perfil
  decorates_association :ubicacion

  def fecha
    perfil.fecha.try :to_s, :dma
  end

  def etiquetas
    perfil.etiquetas.join(', ')
  end

  def reconocedores
    perfil.reconocedores.join(', ')
  end

end
