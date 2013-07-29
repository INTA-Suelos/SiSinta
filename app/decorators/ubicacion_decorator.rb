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

  def mapa(ancho = 400, alto = 300, zoom = 9)
    h.image_tag "http://maps.google.com/maps/api/staticmap?size=#{
                  ancho}x#{
                  alto}&sensor=false&zoom=#{
                  zoom}&maptype=hybrid&markers=#{
                  source.latitud}%2C#{
                  source.longitud}" unless x.blank? or y.blank?
  end

  private

    def usuario
      context[:usuario] || h.try(:current_usuario)
    end
end
