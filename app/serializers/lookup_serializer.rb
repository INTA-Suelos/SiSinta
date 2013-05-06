class LookupSerializer < ActiveModel::Serializer
  attributes :valor

  def serializable_hash
    object.valor
  end
end
