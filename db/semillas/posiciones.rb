# Los valores posibles para Posición en la ficha de perfiles.
# Fijamos el id porque estas son tablas de lookup o datos prácticamente
# estáticos.
posiciones = [
  { id: 1, valor: 'loma' },
  { id: 2, valor: 'media loma alta' },
  { id: 3, valor: 'media loma' },
  { id: 4, valor: 'media loma baja' },
  { id: 5, valor: 'pendiente' },
  { id: 6, valor: 'tendido' },
  { id: 7, valor: 'pie de loma' },
  { id: 8, valor: 'bajo' }
]

posiciones.each do |posicion|
  # Si algún valor fue cambiado durante el uso de la aplicación, no cambiarlo
  unless Posicion.exists?(posicion[:id])
    Posicion.find_or_create_by(posicion).update_column(:id, posicion[:id])
  end
end
