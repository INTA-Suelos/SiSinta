# Los valores posibles para Anegamiento en la ficha de perfiles.
# Fijamos el id porque estas son tablas de lookup o datos prácticamente
# estáticos.
anegamientos = [
  { id: 1, valor: 'clase 1' },
  { id: 2, valor: 'clase 2' },
  { id: 3, valor: 'clase 3' },
  { id: 4, valor: 'clase 4' },
  { id: 5, valor: 'clase 5' }
]

anegamientos.each do |anegamiento|
  # Si algún valor fue cambiado durante el uso de la aplicación, no cambiarlo
  unless Anegamiento.exists?(anegamiento[:id])
    Anegamiento.find_or_create_by(anegamiento).update_column(:id, anegamiento[:id])
  end
end
