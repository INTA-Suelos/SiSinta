class GeojsonCollectionSerializer < ActiveModel::ArraySerializer
  def as_json(*args)
    factory = RGeo::GeoJSON::EntityFactory.instance

    RGeo::GeoJSON.encode factory.feature_collection(features)
  end

  def features
    object.map do |perfil|
      GeojsonPerfilSerializer.new(perfil.decorate).as_json
    end
  end
end
