# Los valores posibles para ClaseDeErosion en la ficha de perfiles.
# Fijamos el id porque estas son tablas de lookup o datos prácticamente
# estáticos.
erosiones = [
  { id: 1, valor: 'nula' },
  { id: 2, valor: 'ligera' },
  { id: 3, valor: 'moderada' },
  { id: 4, valor: 'severa' },
  { id: 5, valor: 'grave' },
  { id: 6, valor: 'muy grave' }
]

erosiones.each do |erosion|
  # Si algún valor fue cambiado durante el uso de la aplicación, no cambiarlo
  unless ClaseDeErosion.exists?(erosion[:id])
    ClaseDeErosion.find_or_create_by(erosion).update_column(:id, erosion[:id])
  end
end
