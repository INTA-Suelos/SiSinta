# Restricciones para determinar el matcheo en las rutas de la API
class ApiConstraints
  # v es un parámetro requerido e indica la versión de la API
  def initialize(v:, default: false)
    @version = v
    @default = default
  end

  # Siempre matchea si es la ruta default. Si no, verifica el Accept header por
  # la versión específica de la aplicación.
  def matches?(request)
    @default ||
      request.headers['Accept'].include?("application/vnd.sisar.v#{@version}")
  end
end
