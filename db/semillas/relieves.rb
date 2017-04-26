# Los valores posibles para Relieve en la ficha de perfiles.
# Fijamos el id porque estas son tablas de lookup o datos prácticamente
# estáticos.
relieves = [
  { id: 1, valor: 'pronunciado' },
  { id: 2, valor: 'normal' },
  { id: 3, valor: 'subnormal' },
  { id: 4, valor: 'cóncavo' }
]

relieves.each do |relieve|
  # Si algún valor fue cambiado durante el uso de la aplicación, no cambiarlo
  unless Relieve.exists?(relieve[:id])
    Relieve.find_or_create_by(relieve).update_column(:id, relieve[:id])
  end
end
