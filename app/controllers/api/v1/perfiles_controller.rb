class API::V1::PerfilesController < API::V1::BaseController
  before_action :cargar_usuario

  has_scope :pagina, default: 1
  has_scope :per, as: :filas

  load_and_authorize_resource

  def index
    @perfiles = apply_scopes(@perfiles)

    render json: @perfiles
  end

  def show
    render json: @perfil
  end
end
