class GeojsonPerfilSerializer < ActiveModel::Serializer
  attributes :id, :numero, :nombre, :fecha

  def as_json(*args)
    self.to_feature
  end

  def to_feature
    factory = RGeo::GeoJSON::EntityFactory.instance
    factory.feature(object.coordenadas, nil, attributes)
  end
end
