class SerieSerializer < ActiveModel::Serializer
  attributes :id, :nombre, :simbolo, :descripcion
end
