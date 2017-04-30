# Serializer simple de Provincia
class ProvinciaSerializer < ActiveModel::Serializer
  # Sólo se serializa como su nombre
  def serializable_hash
    object.nombre
  end
end
