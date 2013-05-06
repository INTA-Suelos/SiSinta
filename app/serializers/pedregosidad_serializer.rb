class PedregosidadSerializer < ActiveModel::Serializer
  has_one  :clase, serializer: LookupSerializer
  has_one  :subclase, serializer: LookupSerializer
end
