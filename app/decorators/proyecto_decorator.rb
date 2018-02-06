# Modelo de presentación del Proyecto
class ProyectoDecorator < ApplicationDecorator
  decorates_association :perfiles, with: PaginadorDecorator
  decorates_association :usuario

  # Remover tags y limitar longitud para el index
  def fragmento_descripcion
    h.strip_tags(source.descripcion).try(:truncate, 35)
  end

  # Remover tags y limitar longitud para el index
  def fragmento_cita
    h.strip_tags(source.cita).try(:truncate, 35)
  end
end
