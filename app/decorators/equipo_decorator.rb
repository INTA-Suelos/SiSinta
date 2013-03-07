class EquipoDecorator < ApplicationDecorator
  decorates_association :miembros, with: PaginadorDecorator

  def to_s
    source.nombre
  end

  def miembro_preparado
    source.miembros.build
  end
end
