# -*- encoding : utf-8 -*-
module GeojsonHelper

  #
  #
  # * *Args*    :
  #   - ++ ->
  # * *Returns* :
  #   -
  # * *Raises* :
  #   - ++ ->
  #
  def como_geojson(objetos, metodo_geom)
    factory = RGeo::GeoJSON::EntityFactory.instance

    features = []
    objetos.each do |o|
      features << factory.feature(o.send(metodo_geom), o, o.propiedades_publicas)
    end

    RGeo::GeoJSON.encode factory.feature_collection(features)
  end
end
