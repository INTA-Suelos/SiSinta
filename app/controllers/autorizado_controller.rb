# Define filtros y manejo de errores para los controladores web con acciones
# que requieren autenticación (devise) y autorización (cancancan).
class AutorizadoController < ApplicationController

  ### Autenticación con Devise
  before_filter :authenticate_usuario!

  ### Autorización con CanCan

  # Asegura que revisemos la autorización en cada acción, excepto en los
  # controladores de devise
  check_authorization unless: :devise_controller?

  # Recupera las excepciones por tratar de acceder a un recurso sin
  # autorización
  rescue_from CanCan::AccessDenied do |e|
    flash[:error] = I18n.t 'unauthorized.detail'
    volver
  end
end
