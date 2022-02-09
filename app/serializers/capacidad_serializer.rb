class CapacidadSerializer < ActiveModel::Serializer
  attributes :subclases

  has_one  :clase, serializer: ClaseDeCapacidadSerializer

  # Devolver la lista de códigos de subclases en su propia columna.
  def subclases
    resultado = []
    object.subclases.each do |subclase|
      resultado << subclase.codigo
    end
    resultado.join(' ')
  end
end
