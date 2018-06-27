# Custom application configuration
Rails.application.configure do
  config.app_name = 'SiSINTA'

  # Configuración default para la validación de las coordenadas (WGS 84).
  # Latitud es y, longitud es x.
  config.rango_y = -90..90
  config.rango_x = -180..180

  # Precisión a mostrar para las coordenadas
  config.precision = 6

  # Default map view
  config.zoom = 4
  config.center = [-40, -65]
end
