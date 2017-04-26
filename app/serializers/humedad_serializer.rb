class HumedadSerializer < ActiveModel::Serializer
  has_one  :clase, serializer: LookupSerializer
  # FIXME Devolver las subclases como lista de valores
  has_many :subclases, serializer: LookupSerializer
end
