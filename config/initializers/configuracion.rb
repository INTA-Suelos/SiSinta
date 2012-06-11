Suelos::Application.configure do
  # Configuración default para la validación de las coordenadas (WGS 84)
  config.rango_x = -90..90
  config.rango_y = -180..180
  
  # Precisión a mostrar para las coordenadas
  config.precision = 6
end
