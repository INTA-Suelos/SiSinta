class GeojsonCollectionSerializer < ActiveModel::ArraySerializer
  def as_json(*args)
    factory = RGeo::GeoJSON::EntityFactory.instance

    features = @object.map do |perfil|
      GeojsonPerfilSerializer.new(perfil).as_json
    end

    RGeo::GeoJSON.encode factory.feature_collection(features)
  end
end
