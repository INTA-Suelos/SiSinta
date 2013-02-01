class ApplicationDecorator < Draper::Base
  def nuevo_perfil
    PerfilDecorator.new(Perfil.new)
  end
end
