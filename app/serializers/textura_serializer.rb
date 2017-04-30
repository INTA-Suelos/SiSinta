class TexturaSerializer < ActiveModel::Serializer
  attributes :clase, :textura, :suelo

  def serializable_hash
    object.clase
  end
end
