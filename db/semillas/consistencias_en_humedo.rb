# Los valores posibles para ConsistenciaEnHumedo en la ficha de perfiles.
# Fijamos el id porque estas son tablas de lookup o datos prácticamente
# estáticos.
consistencias_en_humedo = [
  { id: 1, valor: 'suelto' },
  { id: 2, valor: 'muy friable' },
  { id: 3, valor: 'friable' },
  { id: 4, valor: 'firme' },
  { id: 5, valor: 'muy firme' },
  { id: 6, valor: 'extremadamente firme' }
]

consistencias_en_humedo.each do |consistencia_en_humedo|
  # Si algún valor fue cambiado durante el uso de la aplicación, no cambiarlo
  unless ConsistenciaEnHumedo.exists?(consistencia_en_humedo[:id])
    ConsistenciaEnHumedo.find_or_create_by(consistencia_en_humedo).update_column(:id, consistencia_en_humedo[:id])
  end
end
