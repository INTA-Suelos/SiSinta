# Los valores posibles para TipoDeLimite en la ficha de perfiles.
# Fijamos el id porque estas son tablas de lookup o datos prácticamente
# estáticos.
tipos_de_limite = [
  { id: 1, valor: 'abrupto' },
  { id: 2, valor: 'claro' },
  { id: 3, valor: 'gradual' },
  { id: 4, valor: 'difuso' }
]

tipos_de_limite.each do |tipo_de_limite|
  # Si algún valor fue cambiado durante el uso de la aplicación, no cambiarlo
  unless TipoDeLimite.exists?(tipo_de_limite[:id])
    TipoDeLimite.find_or_create_by(tipo_de_limite).update_column(:id, tipo_de_limite[:id])
  end
end
