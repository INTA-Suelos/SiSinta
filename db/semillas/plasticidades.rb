# Los valores posibles para Plasticidad en la ficha de perfiles.
# Fijamos el id porque estas son tablas de lookup o datos prácticamente
# estáticos.
plasticidades = [
  { id: 1, valor: 'no plástico' },
  { id: 2, valor: 'ligeramente plástico' },
  { id: 3, valor: 'plástico' },
  { id: 4, valor: 'muy plástico' }
]

plasticidades.each do |plasticidad|
  # Si algún valor fue cambiado durante el uso de la aplicación, no cambiarlo
  unless Plasticidad.exists?(plasticidad[:id])
    Plasticidad.find_or_create_by(plasticidad).update_column(:id, plasticidad[:id])
  end
end
