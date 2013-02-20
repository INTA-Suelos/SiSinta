class EquipoDecorator < ApplicationDecorator
  decorates_association :miembros, with: PaginadorDecorator

  def to_s
    source.nombre
  end
end
