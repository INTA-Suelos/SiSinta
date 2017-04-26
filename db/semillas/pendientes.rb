# Los valores posibles para Pendiente en la ficha de perfiles.
# Fijamos el id porque estas son tablas de lookup o datos prácticamente
# estáticos.

pendientes = [
  { id: 1, valor: '0 - 1%' },
  { id: 2, valor: '1 - 3%' },
  { id: 3, valor: '3 - 10%' },
  { id: 4, valor: '10 - 25%' },
  { id: 5, valor: '25 - 45%' },
  { id: 6, valor: '45 - 100%' }
]

pendientes.each do |pendiente|
  # Si algún valor fue cambiado durante el uso de la aplicación, no cambiarlo
  unless Pendiente.exists?(pendiente[:id])
    Pendiente.find_or_create_by(pendiente).update_column(:id, pendiente[:id])
  end
end
