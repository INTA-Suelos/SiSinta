class Ubicacion < ActiveRecord::Base
  class_attribute :config
  self.config = Rails.application.config

  attr_accessor :x, :y, :srid

  # Latitud (y), Longitud (x)
  alias_attribute :longitud, :x
  alias_attribute :latitud,  :y

  belongs_to :perfil, inverse_of: :ubicacion
  delegate :publico, :usuario, :usuario_id, to: :perfil

  validates :perfil, presence: true
  validates :x, inclusion: {
    in: config.rango_x, allow_blank: true, message: 'No está dentro del rango permitido' }
  validates :y, inclusion: {
    in: config.rango_y, allow_blank: true, message: 'No está dentro del rango permitido' }

  before_validation :arreglar_coordenadas
  after_initialize :cargar_x_y

  def self.en_caja(noreste: {}, sudoeste: {})
    fabrica = RGeo::Geographic.spherical_factory

    ne = fabrica.point noreste[:longitud], noreste[:latitud]
    so = fabrica.point sudoeste[:longitud], sudoeste[:latitud]
    caja = RGeo::Cartesian::BoundingBox.create_from_points(ne, so).to_geometry

    where('coordenadas && ?', caja)
  end

  # Encuentra las ubicaciones dentro del polígono o polígonos
  def self.en_poligonos(poligonos)
    puntos = Ubicacion.arel_table[:coordenadas]

    where(poligonos.st_intersects(puntos))
  end

  # Encuentra las ubicaciones dentro de una o más provincias del mismo país
  def self.en_provincias(provincia_ids, data_oficial)
    # Si no tenemos data oficial de polígonos, no podemos buscar ubicaciones
    return Ubicacion.none unless data_oficial.respond_to?(:poligonos)

    # TODO Ver si se puede unificar con el otro where
    gids = Provincia.select(:data_oficial_id).where(id: provincia_ids)

    # Se configura la consulta según la tabla que contiene los datos
    # geográficos de estas provincias
    Ubicacion.en_poligonos(data_oficial.poligonos)
      .where(data_oficial.table_name => { data_oficial.primary_key => gids })
      .from("ubicaciones, #{data_oficial.table_name}")
  end

  def self.ransackable_attributes(auth_object = nil)
    super(auth_object) - ['created_at', 'updated_at', 'perfil_id', 'id']
  end

  def self.grados_a_decimal(coordenada)
    unless coordenada.blank?
      grados, minutos, segundos = coordenada.to_s.split(' ').push(0, 0, 0).map {|i| i.to_f}
      decimal = grados.abs + minutos/60 + segundos/3600
      decimal *= -1 if grados < 0
      return self.redondear(decimal)
    end
  end

  def self.transformar_de_wgs84_a(srid, x, y)
    self.transformar(4326, srid, x, y)
  end

  def self.transformar(srid_origen, srid_destino, x, y, proyectar = true)
    unless x.blank? || y.blank?
      fabrica_origen  = FormatoDeCoordenadas.fabrica(srid_origen)
      fabrica_destino = FormatoDeCoordenadas.fabrica(srid_destino)
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

  # FIXME Si el objeto ya tiene registrado un punto, por qué lo pasamos?
  def transformar_a_wgs84!(srid, x, y)
    self.coordenadas = Ubicacion.transformar(srid, 4326, x, y)
  end

  def coordenadas=(c)
    super(c)
    cargar_x_y
  end

  # TODO Invertir géneros
  def geolocalizado?
    coordenadas.present?
  end
  alias_method :geolocalizada?, :geolocalizado?

  private

    # TODO Unificar funcionamiento, no convertir coordenadas si es nil
    def arreglar_coordenadas
      if srid.to_i.eql?(4326) || srid.blank?
        self.x = Ubicacion.grados_a_decimal(x)
        self.y = Ubicacion.grados_a_decimal(y)
      else
        transformar_a_wgs84!(srid, x, y)
      end
      self.coordenadas = "POINT(#{x} #{y})"
    end

    # Carga las variables de instancia donde accedemos a x e y, desde las coordenadas.
    def cargar_x_y
      self.x = coordenadas.x if coordenadas
      self.y = coordenadas.y if coordenadas
      self.srid = 4326
    end
end
