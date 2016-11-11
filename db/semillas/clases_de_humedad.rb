# Los valores posibles para Clase de Humedad en la ficha de perfiles.
# Fijamos el id porque estas son tablas de lookup o datos prácticamente
# estáticos.
clases = [
  { id: 1, valor: 'uniforme' },
  { id: 2, valor: 'no uniforme' }
]

clases.each do |clase|
  # Si algún valor fue cambiado durante el uso de la aplicación, no cambiarlo
  unless ClaseDeHumedad.exists?(clase[:id])
    ClaseDeHumedad.find_or_create_by(clase).update_column(:id, clase[:id])
  end
end
