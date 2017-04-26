# Formatos de Coordenadas que entiende el sistema por default. Principalmente
# los usados en Argentina.
formatos_de_coordenadas = [
  { id: 1, srid: 4326,
    descripcion: 'Geográficas WGS84' },
  { id: 2, srid: 22191,
    descripcion: 'Planas en Campo Inchauspe / Argentina 1' },
  { id: 3, srid: 22192,
    descripcion: 'Planas en Campo Inchauspe / Argentina 2' },
  { id: 4, srid: 22193,
    descripcion:  'Planas en Campo Inchauspe / Argentina 3' },
  { id: 5, srid: 22194,
    descripcion: 'Planas en Campo Inchauspe / Argentina 4' },
  { id: 6, srid: 22195,
    descripcion: 'Planas en Campo Inchauspe / Argentina 5' },
  { id: 7, srid: 22196,
    descripcion: 'Planas en Campo Inchauspe / Argentina 6' },
  { id: 8, srid: 22197,
    descripcion: 'Planas en Campo Inchauspe / Argentina 7' },
  { id: 9, srid: 22171,
    descripcion: 'POSGAR 94 / POSGAR 98 / Argentina 1' },
  { id: 10, srid: 22172,
    descripcion: 'POSGAR 94 / POSGAR 98 / Argentina 2' },
  { id: 11, srid: 22173,
    descripcion: 'POSGAR 94 / POSGAR 98 / Argentina 3' },
  { id: 12, srid: 22174,
    descripcion: 'POSGAR 94 / POSGAR 98 / Argentina 4' },
  { id: 13, srid: 22175,
    descripcion: 'POSGAR 94 / POSGAR 98 / Argentina 5' },
  { id: 14, srid: 22176,
    descripcion: 'POSGAR 94 / POSGAR 98 / Argentina 6' },
  { id: 15, srid: 22177,
    descripcion: 'POSGAR 94 / POSGAR 98 / Argentina 7' },
  { id: 16, srid: 32718,
    descripcion: 'Planas en UTM - zona 18S' },
  { id: 17, srid: 32719,
    descripcion: 'Planas en UTM - zona 19S' },
  { id: 18, srid: 32720,
    descripcion: 'Planas en UTM - zona 20S' },
  { id: 19, srid: 32721,
    descripcion: 'Planas en UTM - zona 21S' }
]

formatos_de_coordenadas.each do |formato|
  # Si algún valor fue cambiado durante el uso de la aplicación, no cambiarlo
  unless FormatoDeCoordenadas.exists?(formato[:id])
    FormatoDeCoordenadas.find_or_create_by(formato).update_column(:id, formato[:id])
  end
end
