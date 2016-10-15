class SerieSerializer < ActiveModel::Serializer
  # TODO provincia
  attributes :nombre, :simbolo, :descripcion
end
