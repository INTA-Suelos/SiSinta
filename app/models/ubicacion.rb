# -*- encoding : utf-8 -*-
class Ubicacion < ActiveRecord::Base
  before_save :arreglar_coordenadas
  after_initialize :cargar_x_y

  self.rgeo_factory_generator = RGeo::Geos.factory_generator(srid: 4326,
                                wkt_parser: :geos, wkt_generator: :geos,
                                wkb_parser: :geos, wkb_generator: :geos)

  attr_reader :x, :y

  belongs_to :calicata, :inverse_of => :ubicacion

  validates_presence_of :calicata
  validates_inclusion_of :x, in: -90..90, allow_blank: true
  validates_inclusion_of :y, in: -180..180, allow_blank: true

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
    "#{@x} #{@y}"
  end

  def x=(nuevo_x);    @x = a_decimal(nuevo_x)   end
  def y=(nuevo_y);    @y = a_decimal(nuevo_y)   end

  def coordenadas_en_geojson
    RGeo::GeoJSON.encode(coordenadas) unless coordenadas.nil?
  end

  def to_s
    self.try(:descripcion) unless self.try(:punto)
  end

  private

  def arreglar_coordenadas
    self.coordenadas = "POINT(#{a_decimal(@x)} #{a_decimal(@y)})"
  end

  def a_decimal(coordenada)
    if coordenada
      grados, minutos, segundos = coordenada.to_s.split(' ').push(0,0,0).map {|i| i.to_f}
      if grados < 0
        minutos *= -1
        segundos *= -1
      end
      grados + minutos/60 + segundos/3600
    end
  end

  def cargar_x_y
    @x = coordenadas.x if coordenadas
    @y = coordenadas.y if coordenadas
  end
end
