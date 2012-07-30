# encoding: utf-8
class Ubicacion < ActiveRecord::Base
  before_validation :arreglar_coordenadas
  after_initialize :cargar_x_y

  class_attribute :config
  self.config = SiSINTA::Application.config

  set_rgeo_factory_for_column  :coordenadas,
                               FormatoDeCoordenadas.srid(4326).fabrica

  attr_accessor :x, :y, :srid

  # Latitud (y), Longitud (x)
  alias_attribute :longitud, :x
  alias_attribute :latitud,  :y

  belongs_to :calicata, :inverse_of => :ubicacion

  validates_presence_of :calicata
  validates_inclusion_of :x,  in: config.rango_x, allow_blank: true,
                              message: "No está dentro del rango permitido"
  validates_inclusion_of :y,  in: config.rango_y, allow_blank: true,
                              message: "No está dentro del rango permitido"

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

  def punto=(punto)
    if punto.instance_of? String then
      @x, @y = punto.split(' ')
    else
      @x = punto.x
      @y = punto.y
    end
  end

  def coordenadas_en_geojson
    RGeo::GeoJSON.encode(coordenadas) unless coordenadas.nil?
  end

  def to_s
    punto
  end

  def self.grados_a_decimal(coordenada)
    unless coordenada.blank?
      grados, minutos, segundos = coordenada.to_s.split(' ').push(0,0,0).map {|i| i.to_f}
      decimal = grados.abs + minutos/60 + segundos/3600
      decimal *= -1 if grados < 0
      return decimal.round config.precision
    end
  end

  def transformar_a_wgs84!(srid, x, y)
    self.coordenadas = Ubicacion.transformar(srid, 4326, x, y)
  end

  def self.transformar_de_wgs84_a(srid, x, y)
    self.transformar(4326, srid, x, y)
  end

  def self.transformar(origen, destino, x, y, proyectar = true)
    RGeo::Feature.cast(FormatoDeCoordenadas.srid(origen).fabrica.point(x.to_f, y.to_f),
      factory: FormatoDeCoordenadas.srid(destino).fabrica, project: proyectar)
  end

  def coordenadas=(c)
    super(c)
    cargar_x_y
  end

  private

    def arreglar_coordenadas
      if @srid.to_i.eql?(4326) or @srid.blank?
        @x = Ubicacion.grados_a_decimal(@x)
        @y = Ubicacion.grados_a_decimal(@y)
      else
        transformar_a_wgs84!(@srid, @x, @y)
      end
      self.coordenadas = "POINT(#{@x} #{@y})"
    end

    def cargar_x_y
      @x = coordenadas.x if coordenadas
      @y = coordenadas.y if coordenadas
      @srid = 4326
    end

end
