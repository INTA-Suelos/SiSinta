class CapacidadSerializer < ActiveModel::Serializer
  has_one  :clase, serializer: ClaseDeCapacidadSerializer
  # FIXME Devolver las subclases como lista de códigos
  has_many :subclases, serializer: SubclaseDeCapacidadSerializer
end
