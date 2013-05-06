class UbicacionSerializer < ActiveModel::Serializer
  attributes  :descripcion, :recorrido, :mosaico, :aerofoto, :coordenadas
end
