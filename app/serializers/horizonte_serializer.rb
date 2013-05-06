class HorizonteSerializer < ActiveModel::Serializer
  attributes  :id, :profundidad_superior, :color_seco, :color_humedo, :tipo,
              :profundidad_inferior, :ph, :co3, :concreciones, :barnices,
              :moteados, :humedad, :raices, :formaciones_especiales

  has_one :analitico
  has_one :limite, serializer: LimiteDeHorizonteSerializer
  has_one :consistencia
  has_one :estructura
  has_one :textura, serializer: LookupSerializer
end
