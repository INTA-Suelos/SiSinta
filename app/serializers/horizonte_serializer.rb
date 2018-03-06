# Serializador para cada horizonte
class HorizonteSerializer < ActiveModel::Serializer
  attributes  :id, :profundidad_superior, :profundidad_inferior, :ph,
              :co3, :concreciones, :barnices, :moteados, :humedad, :raices,
              :formaciones_especiales

  # Desde un Perfil se ve como "Clase Hz"
  attribute :tipo, key: :horizonte

  has_one :analitico
  has_one :limite, serializer: LimiteDeHorizonteSerializer
  has_one :consistencia
  has_one :estructura
  has_one :textura
  has_one :color_seco
  has_one :color_humedo
end
