# Las provincias válidas para las series.
# Fijamos el id porque estas son tablas de lookup o datos prácticamente
# estáticos.
provincias = [
  { id: 1, nombre: 'Buenos Aires', data_oficial_id: 5, data_oficial_type: 'IgnProvincia' },
  { id: 2, nombre: 'Capital Federal', data_oficial_id: 18, data_oficial_type: 'IgnProvincia' },
  { id: 3, nombre: 'Catamarca', data_oficial_id: 14, data_oficial_type: 'IgnProvincia' },
  { id: 4, nombre: 'Chaco', data_oficial_id: 2, data_oficial_type: 'IgnProvincia' },
  { id: 5, nombre: 'Chubut', data_oficial_id: 17, data_oficial_type: 'IgnProvincia' },
  { id: 6, nombre: 'Corrientes', data_oficial_id: 1, data_oficial_type: 'IgnProvincia' },
  { id: 7, nombre: 'Córdoba', data_oficial_id: 19, data_oficial_type: 'IgnProvincia' },
  { id: 8, nombre: 'Entre Ríos', data_oficial_id: 3, data_oficial_type: 'IgnProvincia' },
  { id: 9, nombre: 'Formosa', data_oficial_id: 20, data_oficial_type: 'IgnProvincia' },
  { id: 10, nombre: 'Jujuy', data_oficial_id: 13, data_oficial_type: 'IgnProvincia' },
  { id: 11, nombre: 'La Pampa', data_oficial_id: 12, data_oficial_type: 'IgnProvincia' },
  { id: 12, nombre: 'Mendoza', data_oficial_id: 10, data_oficial_type: 'IgnProvincia' },
  { id: 13, nombre: 'Misiones', data_oficial_id: 4, data_oficial_type: 'IgnProvincia' },
  { id: 14, nombre: 'Neuquén', data_oficial_id: 22, data_oficial_type: 'IgnProvincia' },
  { id: 15, nombre: 'Río Negro', data_oficial_id: 16, data_oficial_type: 'IgnProvincia' },
  { id: 16, nombre: 'Salta', data_oficial_id: 9, data_oficial_type: 'IgnProvincia' },
  { id: 17, nombre: 'San Juan', data_oficial_id: 8, data_oficial_type: 'IgnProvincia' },
  { id: 18, nombre: 'San Luis', data_oficial_id: 7, data_oficial_type: 'IgnProvincia' },
  { id: 19, nombre: 'Santa Cruz', data_oficial_id: 15, data_oficial_type: 'IgnProvincia' },
  { id: 20, nombre: 'Santa Fe', data_oficial_id: 21, data_oficial_type: 'IgnProvincia' },
  { id: 21, nombre: 'Santiago del Estero', data_oficial_id: 6, data_oficial_type: 'IgnProvincia' },
  { id: 22, nombre: 'Tierra del Fuego', data_oficial_id: 24, data_oficial_type: 'IgnProvincia' },
  { id: 23, nombre: 'Tucumán', data_oficial_id: 23, data_oficial_type: 'IgnProvincia' },
  { id: 24, nombre: 'La Rioja', data_oficial_id: 11, data_oficial_type: 'IgnProvincia' }
]

provincias.each do |provincia|
  # Si algún valor fue cambiado durante el uso de la aplicación, no cambiarlo
  unless Provincia.exists?(provincia[:id])
    Provincia.find_or_create_by(provincia).update_column(:id, provincia[:id])
  end
end
