class FormatoDeCoordenadas < Lookup
  # Lo declaro para que ActiveHash genere el finder
  field :srid

  def self.srid(srid)
    find_by_srid(srid)
  end

  def fabrica
    @fabrica || cargar_fabrica
  end

  private

  def cargar_fabrica
    @fabrica = RGeo::Geos.factory(
      srs_database: RGeo::CoordSys::SRSDatabase::ActiveRecordTable.new,
      srid:         self.srid
    )
  end

end
