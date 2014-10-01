# encoding: utf-8
class PerfilDecorator < ApplicationDecorator
  decorates_association :ubicacion
  decorates_association :serie
  decorates_association :proyecto
  decorates_association :adjuntos, with: PaginadorDecorator
  decorates_association :analiticos
  decorates_association :usuario
  decorates_association :humedad
  decorates_association :capacidad
  decorates_association :horizontes

  def fecha
    if source.fecha?
      source.fecha.to_date.to_s :dma
    end
  end

  def etiquetas
    source.etiquetas.join(', ')
  end

  def reconocedores
    source.reconocedores.join(', ')
  end

  def to_s
    source.numero || source.nombre
  end

  # Para el +FormHelper+ necesito los objetos instanciados, aunque no tengan
  # asociaciones realizadas, asique acá les asignamos un objeto nuevo si no
  # tenían ya
  def preparar
    source.serie         ||= Serie.new
    source.grupo         ||= Grupo.new
    source.paisaje       ||= Paisaje.new
    source.capacidad     ||= Capacidad.new
    source.fase          ||= Fase.new
    source.ubicacion     ||= Ubicacion.new
    source.humedad       ||= Humedad.new
    source.pedregosidad  ||= Pedregosidad.new
    source.erosion       ||= Erosion.new
    horizontes.each do |h|
      h.preparar
    end
    self
  end

  def numero
    source.numero || source.to_param
  end

  def link_a_serie
    h.link_to nombre, serie, class: 'perfil_nombre' if serie.present?
  end

  def grupo
    GrupoDecorator.new source.try(:grupo)
  end

  def fase
    FaseDecorator.new source.try(:fase)
  end

  # En el GeoJSON le decimos `clase` a grupo + fase. Sólo se muestra si el
  # perfil es público o el usuario puede leerlo.
  def clase
    if publico? || h.can?(:read, source)
      [grupo.descripcion, fase.nombre].join(' ').strip
    else
      'No disponible'
    end
  end
end
