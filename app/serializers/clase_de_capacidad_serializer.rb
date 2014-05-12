class ClaseDeCapacidadSerializer < ActiveModel::Serializer
  attributes :codigo, :descripcion, :agrupamiento

  def serializable_hash
    object.codigo
  end
end
