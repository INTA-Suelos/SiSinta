# Los valores posibles para Clase de Pedregosidad en la ficha de perfiles.
# Fijamos el id porque estas son tablas de lookup o datos prácticamente
# estáticos.
clases = [
  { id: 1, valor: 'pedregosidad' },
  { id: 2, valor: 'rocosidad' }
]

clases.each do |clase|
  # Si algún valor fue cambiado durante el uso de la aplicación, no cambiarlo
  unless ClaseDePedregosidad.exists?(clase[:id])
    ClaseDePedregosidad.find_or_create_by(clase).update_column(:id, clase[:id])
  end
end
