class HumedadSerializer < ActiveModel::Serializer
  has_one  :clase, serializer: LookupSerializer
  has_many :subclases, serializer: LookupSerializer
end
