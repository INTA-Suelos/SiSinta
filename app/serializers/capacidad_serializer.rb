class CapacidadSerializer < ActiveModel::Serializer
  has_one  :clase, serializer: ClaseDeCapacidadSerializer
  has_many :subclases, serializer: SubclaseDeCapacidadSerializer
end
