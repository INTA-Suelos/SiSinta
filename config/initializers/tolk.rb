# Configuración del engine de traducciones
Tolk.config do |config|
  # No traducir strings externas al proyecto
  config.exclude_gems_token = true
end

# Cómo autenticar a los usuarios que acceden al traductor
Tolk::ApplicationController.authenticator = proc do
  # Verificar que esté logueado
  authenticate_usuario!

  # Verificar que tenga permisos de traducción
  authorize! :traducir, Tolk
end
