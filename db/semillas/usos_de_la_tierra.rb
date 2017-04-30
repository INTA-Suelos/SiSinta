# Los valores posibles para Uso de la tierra en la ficha de perfiles.
# Fijamos el id porque estas son tablas de lookup o datos prácticamente
# estáticos.
usos = [
  { id: 1, valor: 'agrícola' },
  { id: 2, valor: 'ganadero' },
  { id: 3, valor: 'agricolo-ganadero' },
  { id: 4, valor: 'ganadero-agrícola' },
  { id: 5, valor: 'frutícola' },
  { id: 6, valor: 'hortícola' },
  { id: 7, valor: 'bosque/monte' },
  { id: 8, valor: 'natural' },
  { id: 9, valor: 'bosque implantado' },
  { id: 10, valor: 'tierra improductiva' },
  { id: 11, valor: 'miscelánea' }
]

usos.each do |uso|
  # Si algún valor fue cambiado durante el uso de la aplicación, no cambiarlo
  unless UsoDeLaTierra.exists?(uso[:id])
    UsoDeLaTierra.find_or_create_by(uso).update_column(:id, uso[:id])
  end
end
