# Los valores posibles para Sales en la ficha de perfiles.
# Fijamos el id porque estas son tablas de lookup o datos prácticamente
# estáticos.

sales = [
  { id: 1, valor: 'clase 0' },
  { id: 2, valor: 'clase 1' },
  { id: 3, valor: 'clase 2' },
  { id: 4, valor: 'clase 3' },
  { id: 5, valor: 'clase 4' }
]

sales.each do |sal|
  # Si algún valor fue cambiado durante el uso de la aplicación, no cambiarlo
  unless Sal.exists?(sal[:id])
    Sal.find_or_create_by(sal).update_column(:id, sal[:id])
  end
end
