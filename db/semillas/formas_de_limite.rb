# Los valores posibles para FormaDeLimite en la ficha de perfiles.
# Fijamos el id porque estas son tablas de lookup o datos prácticamente
# estáticos.
formas_de_limite = [
  { id: 1, valor: 'suave' },
  { id: 2, valor: 'ondulado' },
  { id: 3, valor: 'irregular' },
  { id: 4, valor: 'quebrado' }
]

formas_de_limite.each do |forma_de_limite|
  # Si algún valor fue cambiado durante el uso de la aplicación, no cambiarlo
  unless FormaDeLimite.exists?(forma_de_limite[:id])
    FormaDeLimite.find_or_create_by(forma_de_limite).update_column(:id, forma_de_limite[:id])
  end
end
