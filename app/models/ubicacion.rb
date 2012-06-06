# -*- encoding : utf-8 -*-
class Ubicacion < ActiveRecord::Base

  # Permite "latitud, longitud", con valores de latitud de -90 a 90 y de longitud de -180 a 180
  # De: http://www.dbws.net/blog/2009/10/23/regex-validation-of-latitude-and-longitude/
  # Y según http://spatialreference.org/ref/epsg/4326/
  #   WGS84 Bounds: -180.0000, -90.0000, 180.0000, 90.0000
  #   Projected Bounds: -180.0000, -90.0000, 180.0000, 90.0000
  #
  EPSG_4326 = /(-?[0-8]?[0-9](\.\d*)?)|-?90(\.[0]*)? (-?([1]?[0-7][1-9]|[1-9]?[0-9])?(\.\d*)?)|-?180(\.[0]*)?/

  self.rgeo_factory_generator = RGeo::Geos.factory_generator(srid: 4326,
                                wkt_parser: :geos, wkt_generator: :geos,
                                wkb_parser: :geos, wkb_generator: :geos)

  belongs_to :calicata, :inverse_of => :ubicacion

  validates_presence_of :calicata
  validates_format_of :punto, :with => EPSG_4326, :allow_blank => true


  #
  # Convierte el nombre del mosaico guardardo a coordenadas. Por ejemplo, el
  # mosaico +3760-2-2+ resultaría en las coordenadas -60,708333333 -36,083333333
  # según los siguientes cálculos:
  #   latitud
  #     - 60° 42' 30" == - (60 + 42/60 + 30/3600) == -60,708333333
  #   longitud
  #     - 36° 05' 00" == - (36 + 05/60 + 00/3600) == -36,083333333
  #
  # * *Args*    :
  #   - ++ ->
  # * *Returns* :
  #   -
  # * *Raises* :
  #   - ++ ->
  #
  #def aproximar
  #  "no implementado todavía"
  #end

# == Accesors

  #
  # Sobreescribo el conversor default para que sea llamado por +to_json+ desde
  # el controlador y devuelva geojson para las coordenadas.
  #
  def as_json(options={})
    { :calicata_id => calicata_id,
      :mosaico => mosaico,
      :recorrido => recorrido,
      :aerofoto => aerofoto,
      :descripcion => descripcion,
      :id => id,
      :geojson => coordenadas_en_geojson }
  end

  def punto
    if c = read_attribute(:coordenadas)
      "#{c.x} #{c.y}"
    end
  end

  def x
    coordenadas.x if coordenadas
  end

  def x=(nuevo_x)
    @x = nuevo_x
    write_attribute :coordenadas, "POINT(#{@x} #{@y})"
  end

  def y
    coordenadas.y if coordenadas
  end

  def y=(nuevo_y)
    @y = nuevo_y
    write_attribute :coordenadas, "POINT(#{@x} #{@y})"
  end

  def coordenadas_en_geojson
    RGeo::GeoJSON.encode(coordenadas) unless coordenadas.nil?
  end

  def to_s
    self.try(:descripcion) unless self.try(:punto)
  end

end
