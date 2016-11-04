# Los valores posibles para Subclase de Capacidad en la ficha de perfiles.
# Fijamos el id porque estas son tablas de lookup o datos prácticamente
# estáticos.
subclases = [
  { id: 1, codigo: 'e', descripcion: 'erosión' },
  { id: 2, codigo: 's', descripcion: 'limitaciones en la zona radicular' },
  { id: 3, codigo: 'c', descripcion: 'limitaciones climáticas' },
  { id: 4, codigo: 'w', descripcion: 'drenaje deficiente' }
]

subclases.each do |subclase|
  # Si algún valor fue cambiado durante el uso de la aplicación, no cambiarlo
  unless SubclaseDeCapacidad.exists?(subclase[:id])
    SubclaseDeCapacidad.find_or_create_by(subclase).update_column(:id, subclase[:id])
  end
end
