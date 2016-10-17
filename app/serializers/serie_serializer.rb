class SerieSerializer < ActiveModel::Serializer
  attributes :nombre, :simbolo, :descripcion

  has_one :provincia
end
