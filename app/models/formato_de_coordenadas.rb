# TODO Refactorizar como modelo y refactorizar los métodos
class FormatoDeCoordenadas < Lookup
  # Lo declaro para que ActiveHash genere el finder
  field :srid

  def self.srid(srid)
    find_by_srid(srid.to_i)
  end

  def fabrica
    @fabrica || cargar_fabrica
  end

  def to_str
    descripcion
  end

  private

    def cargar_fabrica
      # TODO Ver cómo pasar la srs_database
      @fabrica = RGeo::Geographic.spherical_factory(srid: srid)
    end

end
