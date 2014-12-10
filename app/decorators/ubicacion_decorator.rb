# encoding: utf-8
class UbicacionDecorator < ApplicationDecorator
  # Transforma del srid real al preferido por el usuario
  def transformar
    @coordenadas ||= Ubicacion.transformar(source.srid, self.srid, source.x, source.y)
  end

  # x de acuerdo al SRID preferido
  def x
    Ubicacion.redondear transformar.try(:x)
  end

  # y de acuerdo al SRID preferido
  def y
    Ubicacion.redondear transformar.try(:y)
  end

  def srid
    (usuario.try(:srid) || 4326).to_i
  end

  def to_s
    source.descripcion || transformar || ''
  end

  def mapa(zoom = 9)
    h.content_tag :div, nil, id: 'mapa',
      data: { geojson: h.perfil_path(perfil, format: :geojson), zoom: zoom, centro: [y, x] }
  end

  private

    def usuario
      context[:usuario] || h.try(:current_usuario)
    end
end
