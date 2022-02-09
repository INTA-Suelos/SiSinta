class HumedadSerializer < ActiveModel::Serializer
  attributes :subclases

  has_one  :clase, serializer: LookupSerializer

  # Devolver la lista de valores de subclases en su propia columna.
  def subclases
    resultado = []
    object.subclases.each do |subclase|
      resultado << subclase.valor
    end
    resultado.join(' ')
  end
end
