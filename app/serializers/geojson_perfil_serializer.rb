class GeojsonPerfilSerializer < ActiveModel::Serializer
  attributes :id, :numero, :fecha, :clase, :serie, :url

  def as_json(*args)
    self.to_feature
  end

  def to_feature
    factory = RGeo::GeoJSON::EntityFactory.instance
    factory.feature(object.coordenadas, nil, attributes)
  end

  def serie
    { 'nombre' => object.serie.nombre,
      'url' => serie_url(object.serie) } if object.serie.present?
  end

  def url
    perfil_url object
  end
end
