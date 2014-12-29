class CapacidadSerializer < ActiveModel::Serializer
  attributes :subclases
  has_one  :clase, serializer: ClaseDeCapacidadSerializer

  # Devolver la lista de códigos de subclases en su propia columna.
  def subclases
    object.subclases.collect(&:codigo).join ' '
  end
end
