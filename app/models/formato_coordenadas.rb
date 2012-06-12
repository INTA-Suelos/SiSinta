class FormatoCoordenadas < Lookup
  alias_attribute :descripcion, :valor1
  alias_attribute :srid, :valor2

  after_initialize :cargar_fabrica

  attr_reader :fabrica

  def self.srid(srid)
    find_by_valor2(srid.to_s)
  end

  private

  def cargar_fabrica
    @fabrica = RGeo::Geos.factory(
      srs_database: RGeo::CoordSys::SRSDatabase::ActiveRecordTable.new,
      srid:         self.srid
    )
  end

end
