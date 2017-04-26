# Los valores posibles para ConsistenciaEnSeco en la ficha de perfiles.
# Fijamos el id porque estas son tablas de lookup o datos prácticamente
# estáticos.
consistencias_en_seco = [
  { id: 1, valor: 'suelto' },
  { id: 2, valor: 'blando' },
  { id: 3, valor: 'ligeramente duro' },
  { id: 4, valor: 'duro' },
  { id: 5, valor: 'muy duro' },
  { id: 6, valor: 'extremadamente duro' }
]

consistencias_en_seco.each do |consistencia_en_seco|
  # Si algún valor fue cambiado durante el uso de la aplicación, no cambiarlo
  unless ConsistenciaEnSeco.exists?(consistencia_en_seco[:id])
    ConsistenciaEnSeco.find_or_create_by(consistencia_en_seco).update_column(:id, consistencia_en_seco[:id])
  end
end
