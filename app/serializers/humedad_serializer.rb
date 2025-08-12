class HumedadSerializer < ActiveModel::Serializer
  attributes :subclases
  has_one  :clase, serializer: LookupSerializer

  # Devolver la lista de valores de subclases en su propia columna.
  def subclases
    object.subclases.collect(&:valor).join ' '
  end
end
