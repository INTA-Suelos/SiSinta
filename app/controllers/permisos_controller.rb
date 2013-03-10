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
      @recurso = buscar_recurso_accesible(params[:modelo], params[:id])
      @usuarios = Usuario.accessible_by(current_ability).includes(:equipos).decorate
      authorize! params[:action], @recurso
    end

    # Carga la clase del modelo según la url y el recurso si es accesible por
    # el usuario actual
    def buscar_recurso_accesible(modelo, id)
      case modelo
        when 'perfil', 'serie', 'proyecto'
          Kernel.const_get(modelo.classify)
        else
          raise ActionController::RoutingError.new(
            "No se puede asignar permisos para #{modelo}"
          )
      end.accessible_by(current_ability).find(id)
    end
end
