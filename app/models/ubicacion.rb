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

  belongs_to :perfil, inverse_of: :ubicacion
  delegate :publico, :usuario, :usuario_id, to: :perfil

  validates_presence_of :perfil
  validates_inclusion_of :x,  in: config.rango_x, allow_blank: true,
                              message: "No está dentro del rango permitido"
  validates_inclusion_of :y,  in: config.rango_y, allow_blank: true,
                              message: "No está dentro del rango permitido"

  def self.ransackable_attributes(auth_object = nil)
    super(auth_object) - ['created_at', 'updated_at', 'perfil_id', 'id']
  end

  def self.grados_a_decimal(coordenada)
    unless coordenada.blank?
      grados, minutos, segundos = coordenada.to_s.split(' ').push(0,0,0).map {|i| i.to_f}
      decimal = grados.abs + minutos/60 + segundos/3600
      decimal *= -1 if grados < 0
      return self.redondear(decimal)
    end
  end

  def self.transformar_de_wgs84_a(srid, x, y)
    self.transformar(4326, srid, x, y)
  end

  def self.transformar(origen, destino, x, y, proyectar = true)
    unless x.blank? || y.blank?
      fabrica_origen  = FormatoDeCoordenadas.srid(origen).fabrica
      fabrica_destino = FormatoDeCoordenadas.srid(destino).fabrica
      RGeo::Feature.cast(
        fabrica_origen.point(x.to_f, y.to_f),
        factory: fabrica_destino,
        project: proyectar)
    end
  end

  def self.redondear(numero)
    numero.try(:round, config.precision)
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

  def to_s
    punto
  end

  def transformar_a_wgs84!(srid, x, y)
    self.coordenadas = Ubicacion.transformar(srid, 4326, x, y)
  end

  def coordenadas=(c)
    super(c)
    cargar_x_y
  end

  def geolocalizado?
    coordenadas.present?
  end
  alias_method :geolocalizada?, :geolocalizado?

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
