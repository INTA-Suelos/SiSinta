# Los valores posibles para Clase de Estructura en la ficha de perfiles.
# Fijamos el id porque estas son tablas de lookup o datos prácticamente
# estáticos.
clases_de_estructura = [
  { id: 1, valor: 'muy finos' },
  { id: 2, valor: 'finos' },
  { id: 3, valor: 'medios' },
  { id: 4, valor: 'gruesos' },
  { id: 5, valor: 'muy gruesos' }
]

clases_de_estructura.each do |clase_de_estructura|
  # Si algún valor fue cambiado durante el uso de la aplicación, no cambiarlo
  unless ClaseDeEstructura.exists?(clase_de_estructura[:id])
    ClaseDeEstructura.find_or_create_by(clase_de_estructura).update_column(:id, clase_de_estructura[:id])
  end
end
