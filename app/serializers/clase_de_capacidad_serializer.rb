class ClaseDeCapacidadSerializer < ActiveModel::Serializer
  # Sólo devolver el código al serializar
  def serializable_hash
    object.codigo
  end
end
