# Autenticación por html y por token (JWT) para la API
class Usuarios::SessionsController < Devise::SessionsController
  respond_to :html, :json

  skip_before_action :verify_authenticity_token, if: :json_request?

  # Sobreescribe la acción default de devise para generar y devolver el JWT si las
  # credenciales son correctas y la solicitud fue json
  def create
    # Default de devise
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?

    # sub es un claim de JWT que identifica al subject (en este caso el
    # usuario que pide el token)
    token = AuthToken.generar sub: resource.id

    respond_with resource, location: after_sign_in_path_for(resource) do |format|
      # Para JSON, se serializa el usuario agregando el token por fuera del hash
      # de datos, como lo espera el cliente
      #
      #   {
      #     usuario: { nombre: 'Juan Salvo', email: 'elena@martita.com' },
      #     token: qwerty
      #   }
      #
      format.json do
        render json: UsuarioSerializer.new(resource).as_json.merge(token: token)
      end
    end
  end

  private

  def json_request?
    request.format.json?
  end
end
