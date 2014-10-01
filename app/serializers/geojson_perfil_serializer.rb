class GeojsonPerfilSerializer < ActiveModel::Serializer
  attributes :id, :numero, :fecha, :clase, :serie

  def as_json(*args)
    self.to_feature
  end

  def to_feature
    factory = RGeo::GeoJSON::EntityFactory.instance
    factory.feature(object.coordenadas, nil, attributes)
  end

  def serie
    object.serie.nombre
  end
end
