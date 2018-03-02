class GeojsonCollectionSerializer < ActiveModel::ArraySerializer
  def as_json(*args)
    factory = RGeo::GeoJSON::EntityFactory.instance

    RGeo::GeoJSON.encode factory.feature_collection(features)
  end

  def features
    perfiles = []

    # Fetch in batches if possible
    iterate = object.respond_to?(:find_each) ? :find_each : :each

    object.send(iterate) do |perfil|
      perfiles << GeojsonPerfilSerializer.new(perfil.decorate).as_json
    end

    perfiles
  end
end
