class SerieDecorator < Draper::Base
  decorates :serie
  decorates_association :perfiles

  def nuevo_perfil
    PerfilDecorator.new(Perfil.new)
  end

end
