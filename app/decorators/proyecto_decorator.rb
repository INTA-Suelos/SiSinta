class ProyectoDecorator < Draper::Base
  decorates :proyecto
  decorates_association :perfil

  def nuevo_perfil
    PerfilDecorator.new(Perfil.new)
  end

end
