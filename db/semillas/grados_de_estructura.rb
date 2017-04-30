# Los valores posibles para Grado de Estructura en la ficha de perfiles.
# Fijamos el id porque estas son tablas de lookup o datos prácticamente
# estáticos.
grados_de_estructura = [
  { id: 1, valor: 'débil' },
  { id: 2, valor: 'moderado' },
  { id: 3, valor: 'fuerte' }
]

grados_de_estructura.each do |grado_de_estructura|
  # Si algún valor fue cambiado durante el uso de la aplicación, no cambiarlo
  unless GradoDeEstructura.exists?(grado_de_estructura[:id])
    GradoDeEstructura.find_or_create_by(grado_de_estructura).update_column(:id, grado_de_estructura[:id])
  end
end
