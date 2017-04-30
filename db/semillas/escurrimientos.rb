# Los valores posibles para Escurrimiento en la ficha de perfiles.
# Fijamos el id porque estas son tablas de lookup o datos prácticamente
# estáticos.
escurrimientos = [
  { id: 1, valor: 'estancado' },
  { id: 2, valor: 'muy lento' },
  { id: 3, valor: 'lento' },
  { id: 4, valor: 'medio' },
  { id: 5, valor: 'rápido' },
  { id: 6, valor: 'muy rápido' }
]

escurrimientos.each do |escurrimiento|
  # Si algún valor fue cambiado durante el uso de la aplicación, no cambiarlo
  unless Escurrimiento.exists?(escurrimiento[:id])
    Escurrimiento.find_or_create_by(escurrimiento).update_column(:id, escurrimiento[:id])
  end
end
