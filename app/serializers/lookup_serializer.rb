# Serializer genérico para los modelos que sólo mantienen un valor
class LookupSerializer < ActiveModel::Serializer
  attributes :valor

  def serializable_hash
    object.valor
  end
end
