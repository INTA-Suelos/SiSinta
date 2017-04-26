# Los valores posibles para Subclase de Humedad en la ficha de perfiles.
# Fijamos el id porque estas son tablas de lookup o datos prácticamente
# estáticos.
subclases = [
  { id: 1, valor: 'seco' },
  { id: 2, valor: 'fresco' },
  { id: 3, valor: 'húmedo' },
  { id: 4, valor: 'mojado' }
]

subclases.each do |subclase|
  # Si algún valor fue cambiado durante el uso de la aplicación, no cambiarlo
  unless SubclaseDeHumedad.exists?(subclase[:id])
    SubclaseDeHumedad.find_or_create_by(subclase).update_column(:id, subclase[:id])
  end
end
