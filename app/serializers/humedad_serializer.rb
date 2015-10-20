class HumedadSerializer < ActiveModel::Serializer
  attributes :subclases
  has_one  :clase, serializer: LookupSerializer

  def subclases
    object.subclases.collect(&:valor).join ', '
  end
end
