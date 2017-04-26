# Los valores posibles para Tipo de Estructura en la ficha de perfiles.
# Fijamos el id porque estas son tablas de lookup o datos prácticamente
# estáticos.
tipos_de_estructura = [
  { id: 1, valor: 'migajosa' },
  { id: 2, valor: 'semimigajosa' },
  { id: 3, valor: 'granular' },
  { id: 4, valor: 'bloques subangulares' },
  { id: 5, valor: 'bloques angulares' },
  { id: 6, valor: 'bloques aplanados' },
  { id: 7, valor: 'bloques cuneiformes' },
  { id: 8, valor: 'prismas simples irregulares' },
  { id: 9, valor: 'prismas' },
  { id: 10, valor: 'prismas simples regulares' },
  { id: 11, valor: 'prismas compuestos irregulares' },
  { id: 12, valor: 'prismas compuestos regulares' },
  { id: 13, valor: 'semicolumnar' },
  { id: 14, valor: 'columnar' },
  { id: 15, valor: 'laminar' },
  { id: 16, valor: 'agregados laminares o platiformes' },
  { id: 17, valor: 'masiva' },
  { id: 18, valor: 'grano suelto' }
]

tipos_de_estructura.each do |tipo_de_estructura|
  # Si algún valor fue cambiado durante el uso de la aplicación, no cambiarlo
  unless TipoDeEstructura.exists?(tipo_de_estructura[:id])
    TipoDeEstructura.find_or_create_by(tipo_de_estructura).update_column(:id, tipo_de_estructura[:id])
  end
end
