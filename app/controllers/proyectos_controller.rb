# encoding: utf-8
class ProyectosController < AutorizadoController
  has_scope :pagina, default: 1
  has_scope :per, as: :filas

  load_and_authorize_resource

  before_filter :asociar_perfiles,            only: [:update]

  # Las acciones +index+ y +show+ funcionan anónimamente, pero igual uso a
  # CanCan para que cargue el recurso
  skip_before_filter :authenticate_usuario!,  only: [:index, :show]
  skip_authorize_resource                     only: [:index, :show]
  skip_authorization_check                    only: [:index, :show]

  def index
    respond_with @proyectos = PaginadorDecorator.decorate(apply_scopes(@proyectos))
  end

  def show
    respond_with @proyecto = @proyecto.decorate
  end

  def new
    @busqueda_perfil = Perfil.search
    respond_with @proyecto = @proyecto.decorate
  end

  def edit
    @busqueda_perfil = Perfil.search
    respond_with @proyecto = @proyecto.decorate
  end

  def create
    # Si falla, responders lo redirige a new
    opciones = if @proyecto.save
      { location: proyecto_o_buscar_perfiles }
    else
      { }
    end

    respond_with @proyecto, opciones
  end

  def update
    # Si falla, responders lo redirige a edit
    opciones = if @proyecto.update_attributes(proyecto_params)
      { location: proyecto_o_buscar_perfiles }
    else
      { }
    end

    respond_with @proyecto, opciones
  end

  def destroy
    respond_with @proyecto.destroy
  end

  private

    def proyecto_params
      # TODO Pasar a require cuando reformule la asociación de perfiles
      if params[:proyecto].present?
        params.require(:proyecto).permit(
          :nombre, :cita, :descripcion,
          perfiles_attributes: %i{ id anular }
        )
      else
        params.permit :perfil_ids
      end
    end

    def asociar_perfiles
      if params[:perfil_ids]
        # Agregamos sólo los ids que no estaban ya
        nuevos = params[:perfil_ids].collect {|id| id.to_i } - @proyecto.perfil_ids
        @proyecto.perfiles << Perfil.find(nuevos)
      end
    end

    # TODO Ver si se puede hacer con polymorphic urls
    def proyecto_o_buscar_perfiles
      case params[:commit]
      when t('comunes.perfiles_asociados.submit')
        session[:despues_de_seleccionar] = proyecto_path(@proyecto)
        seleccionar_perfiles_path(q: params[:q])
      when t('perfiles.seleccionar.submit')
        # Venimos de perfil#seleccionar, asique redirigimos a edit
        edit_proyecto_path(@proyecto)
      else
        @proyecto
      end
    end

end
