# Los valores posibles para Drenaje en la ficha de perfiles.
# Fijamos el id porque estas son tablas de lookup o datos prácticamente
# estáticos.
drenajes = [
  { id: 1, valor: 'clase 0' },
  { id: 2, valor: 'clase 1' },
  { id: 3, valor: 'clase 2' },
  { id: 4, valor: 'clase 3' },
  { id: 5, valor: 'clase 4' },
  { id: 6, valor: 'clase 5' },
  { id: 7, valor: 'clase 6' }
]

drenajes.each do |drenaje|
  # Si algún valor fue cambiado durante el uso de la aplicación, no cambiarlo
  unless Drenaje.exists?(drenaje[:id])
    Drenaje.find_or_create_by(drenaje).update_column(:id, drenaje[:id])
  end
end
