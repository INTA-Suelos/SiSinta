# Controlador base, equivalente a ApplicationController, para todos los
# controladores de la API.
class API::V1::BaseController < ActionController::API
  include CanCan::ControllerAdditions

  # Siempre tratar de decodificar el token. Para forzar que exista y sea
  # válido, usar `validar_token!`
  before_action :decodificar_token

  rescue_from CanCan::AccessDenied, with: :no_autorizado

  protected

  def decodificar_token
    @token ||= AuthToken.new request.headers[:authorization]
  end

  # Si el token no es válido impedir el acceso
  def validar_token!
    head :unauthorized unless @token.valido?
  end

  # Si el token fue decodificado correctamente, encontrar al usuario al que le
  # fue emitido este token
  def cargar_usuario
    @current_usuario ||= Usuario.find(@token.claims[:sub]) if @token.valido?
  end

  # Accessor para cancancan
  def current_user
    @current_usuario
  end

  def no_autorizado
    render json: { errors: [
      { title: I18n.t('unauthorized.title'), status: '403', detail: I18n.t('unauthorized.detail') }
    ] }, status: :forbidden
  end
end
