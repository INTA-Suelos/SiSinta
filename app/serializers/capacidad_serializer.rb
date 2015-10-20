class CapacidadSerializer < ActiveModel::Serializer
  attributes :subclases
  has_one  :clase, serializer: ClaseDeCapacidadSerializer

  def subclases
    object.subclases.collect(&:codigo).join ', '
  end
end
