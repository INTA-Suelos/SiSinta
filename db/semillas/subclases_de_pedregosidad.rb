# Los valores posibles para Subclase de Pedregosidad en la ficha de perfiles.
# Fijamos el id porque estas son tablas de lookup o datos prácticamente
# estáticos.
subclases = [
  { id: 1, valor: 'grado 0' },
  { id: 2, valor: 'grado 1' },
  { id: 3, valor: 'grado 2' },
  { id: 4, valor: 'grado 3' },
  { id: 5, valor: 'grado 4' },
  { id: 6, valor: 'grado 5' }
]

subclases.each do |subclase|
  # Si algún valor fue cambiado durante el uso de la aplicación, no cambiarlo
  unless SubclaseDePedregosidad.exists?(subclase[:id])
    SubclaseDePedregosidad.find_or_create_by(subclase).update_column(:id, subclase[:id])
  end
end
