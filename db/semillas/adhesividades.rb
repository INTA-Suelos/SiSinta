# Los valores posibles para Adhesividad en la ficha de perfiles.
# Fijamos el id porque estas son tablas de lookup o datos prácticamente
# estáticos.
adhesividades = [
  { id: 1, valor: 'no adhesivo' },
  { id: 2, valor: 'ligeramente adhesivo' },
  { id: 3, valor: 'adhesivo' },
  { id: 4, valor: 'muy adhesivo' }
]

adhesividades.each do |adhesividad|
  # Si algún valor fue cambiado durante el uso de la aplicación, no cambiarlo
  unless Adhesividad.exists?(adhesividad[:id])
    Adhesividad.find_or_create_by(adhesividad).update_column(:id, adhesividad[:id])
  end
end
