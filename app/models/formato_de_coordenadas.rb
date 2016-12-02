# Tabla de formatos de coordenadas entendidos por el sistema. Se pueden agregar
# más, siempre y cuando estén en la base de datos SRSDatabase.
# Agregar un formato permite que el sistema lo manipule sin que sean necesarios
# más cambios.
class FormatoDeCoordenadas < ActiveRecord::Base
  validates :srid, presence: true
  validates :descripcion, presence: true

  # Busca e inicializa un Formato según el srid requerido
  def self.srid(srid)
    find_by srid: srid.to_i
  end

  # Busca e inicializa una fábrica de coordenadas según el srid requerido
  def self.fabrica(srid)
    RGeo::Geographic.spherical_factory(
      srs_database: RGeo::CoordSys::SRSDatabase::ActiveRecordTable.new,
      srid: srid.to_i
    )
  end

  # Devuelve la fábrica de coordenadas correspondiente a este Formato
  def fabrica
    @fabrica ||= self.class.fabrica(srid)
  end

  # TODO Mover a decorador y dropear el requerimiento de not null
  def to_str
    descripcion
  end
end
