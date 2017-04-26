# Los valores posibles para Permeabilidad en la ficha de perfiles.
# Fijamos el id porque estas son tablas de lookup o datos prácticamente
# estáticos.
permeabilidades = [
  { id: 1, valor: 'muy lenta' },
  { id: 2, valor: 'lenta' },
  { id: 3, valor: 'moderadamente lenta' },
  { id: 4, valor: 'moderada' },
  { id: 5, valor: 'moderadamente rápida' },
  { id: 6, valor: 'rápida' },
  { id: 7, valor: 'muy rápida' }
]

permeabilidades.each do |permeabilidad|
  # Si algún valor fue cambiado durante el uso de la aplicación, no cambiarlo
  unless Permeabilidad.exists?(permeabilidad[:id])
    Permeabilidad.find_or_create_by(permeabilidad).update_column(:id, permeabilidad[:id])
  end
end
