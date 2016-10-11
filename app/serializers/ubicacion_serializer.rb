class UbicacionSerializer < ActiveModel::Serializer
  attributes :descripcion, :recorrido, :mosaico, :aerofoto, :latitud, :longitud
end
