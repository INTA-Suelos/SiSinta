class PermisosController < AutorizadoController

  skip_load_and_authorize_resource
  skip_authorization_check

  before_filter :cargar_recurso

  def edit
    @controlador = params[:controller]
    @actuales = Usuario.miembros(@recurso).collect(&:id)
    @equipos = Equipo.all
    respond_with @recurso = @recurso.decorate
  end

  def update
    # Destruyo el rol para reasignarlo entero
    @recurso.roles(:miembro).first.try :destroy
    if usuarios = params["usuario_ids"]
      Usuario.find(usuarios).each { |u| u.grant :miembro, @recurso }
    end
    respond_with @recurso
  end

  private

    def cargar_recurso
      @recurso = case params[:modelo]
        when 'perfil', 'equipo'
          modelo.accessible_by(current_ability).find(params[:id])
        else
          raise ActionController::RoutingError.new(
            "No se puede asignar permisos para #{params[:modelo]}"
          )
      end
      authorize! params[:action], @recurso
    end

    def modelo
      Kernel.const_get(params[:modelo].classify)
    end
end
