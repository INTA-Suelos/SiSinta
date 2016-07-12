ActiveSupport.on_load(:active_model_serializers) do
  # FIXME Revisar que no sea necesario para geojson
  ActiveModel::ArraySerializer.root = false
end
