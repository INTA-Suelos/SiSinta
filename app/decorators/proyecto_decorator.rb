class ProyectoDecorator < Draper::Base
  decorates :proyecto
  decorates_association :perfiles

  def nuevo_perfil
    PerfilDecorator.new(Perfil.new)
  end

end
