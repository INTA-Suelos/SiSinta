class PermisosController < AutorizadoController

  skip_load_and_authorize_resource
  skip_authorization_check

  before_filter :cargar_recursos

  def edit
    @controlador = params[:controller]
    @ids = Usuario.miembros(@recurso).collect(&:id)
    @actuales = UsuarioDecorator.decorate_collection @usuarios.find(@ids)
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

    def cargar_recursos
      @recurso = case params[:modelo]
        when 'perfil', 'serie'
          modelo.accessible_by(current_ability).find(params[:id])
        else
          raise ActionController::RoutingError.new(
            "No se puede asignar permisos para #{params[:modelo]}"
          )
      end
      @usuarios = Usuario.accessible_by(current_ability).includes(:equipos).decorate
      authorize! params[:action], @recurso
    end

    def modelo
      Kernel.const_get(params[:modelo].classify)
    end
end
