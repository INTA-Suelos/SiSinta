class Ubicacion < ActiveRecord::Base

  #
  # Permite "latitud, longitud", con valores de latitud de -90 a 90 y de longitud de -180 a 180
  # De: http://www.dbws.net/blog/2009/10/23/regex-validation-of-latitude-and-longitude/
  # Y según http://spatialreference.org/ref/epsg/4326/
  #   WGS84 Bounds: -180.0000, -90.0000, 180.0000, 90.0000
  #   Projected Bounds: -180.0000, -90.0000, 180.0000, 90.0000
  #
  EPSG_4326 = /(-?[0-8]?[0-9](\.\d*)?)|-?90(\.[0]*)? (-?([1]?[0-7][1-9]|[1-9]?[0-9])?(\.\d*)?)|-?180(\.[0]*)?/

  self.rgeo_factory_generator = RGeo::Geos.factory_generator(:srid => 4326,
                                :wkt_parser => :geos, :wkb_parserm => :geos,
                                :wkt_generator => :geos, :wkb_generator => :geos)

  belongs_to :calicata, :inverse_of => :ubicacion, :validate => true

  validates_presence_of :calicata
  validates_format_of :lat_lon, :with => EPSG_4326, :allow_blank => true

# == Accesors

  def lat_lon=(lat_lon)
    write_attribute :coordenadas, "POINT(#{lat_lon})"
  end

  def lat_lon
    if c = read_attribute(:coordenadas)
      "#{c.x} #{c.y}"
    end
  end

  def latitud
    coordenadas.x if coordenadas
  end

  def longitud
    coordenadas.y if coordenadas
  end

end
