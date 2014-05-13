# encoding: utf-8
class SeriesController < AutorizadoController
  autocomplete :serie, :nombre, full: true, extra_data: [:simbolo]
  autocomplete :serie, :simbolo, full: true, extra_data: [:nombre]

  has_scope :pagina, default: 1
  has_scope :per, as: :filas

  load_and_authorize_resource except: [:autocomplete_serie_nombre,
                                       :autocomplete_serie_simbolo]

  with_options only: [:index, :show, :autocomplete_serie_nombre,
                      :autocomplete_serie_simbolo] do |o|
    o.skip_before_filter :authenticate_usuario!
    o.skip_authorization_check
  end

  # Las acciones +index+ y +show+ funcionan anónimamente, pero igual uso a
  # CanCan para que cargue el recurso
  skip_authorize_resource                     only: [:index, :show]

  before_filter :preparar, only: [:index]
  before_filter :ordenar, only: [:index]

  before_filter :asociar_perfiles, only: [:update]

  def index
    respond_with @series = PaginadorDecorator.decorate(apply_scopes(@series))
  end

  def show
    respond_with @serie = @serie.decorate
  end

  def new
    @busqueda_perfil = Perfil.search
    respond_with @serie
  end

  def edit
    @busqueda_perfil = Perfil.search
    respond_with @serie = @serie.decorate
  end

  def create
    # Si falla, responders lo redirige a new
    opciones = if @serie.save
      { location: serie_o_buscar_perfiles }
    else
      { }
    end

    respond_with @serie, opciones
  end

  def update
    # Si falla, responders lo redirige a edit
    opciones = if @serie.update_attributes(serie_params)
      { location: serie_o_buscar_perfiles }
    else
      { }
    end

    respond_with @serie, opciones
  end

  def destroy
    respond_with @serie.destroy
  end

  private

    def serie_params
      # TODO Pasar a require cuando reformule la asociación de perfiles
      if params[:serie].present?
        params.require(:serie).permit(
          :nombre, :simbolo, :descripcion,
          perfiles_attributes: %i{ id anular }
        )
      else
        params.permit :perfil_ids
      end
    end

    def asociar_perfiles
      if params[:perfil_ids]
        # Agregamos sólo los ids que no estaban ya
        nuevos = params[:perfil_ids].collect {|id| id.to_i } - @serie.perfil_ids
        @serie.perfiles << Perfil.find(nuevos)
      end
    end

    # TODO Ver si se puede hacer con polymorphic urls
    def serie_o_buscar_perfiles
      case params[:commit]
      when t('comunes.perfiles_asociados.submit')
        session[:despues_de_seleccionar] = serie_path(@serie)
        seleccionar_perfiles_path(q: params[:q])
      when t('perfiles.seleccionar.submit')
        # Venimos de perfil#seleccionar, asique redirigimos a edit
        edit_serie_path(@serie)
      else
        @serie
      end
    end

    # Prepara el scope para la lista de series
    def preparar
      # Selecciono sólo lo que necesito en el index
      @series ||= Serie.includes(:perfiles)
    end

    # Ordena los resultados según las columnas de la lista. Si son columnas de
    # texto, las normaliza a lowercase.
    def ordenar
      case @metodo = metodo_de_ordenamiento
      when 'nombre', 'simbolo', 'descripcion, cantidad_de_perfiles'
        @metodo = "lower(#{@metodo})"
      else
        # A los date y boolean no se les aplica lower()
      end
      @series = @series.order("#{@metodo} #{direccion_de_ordenamiento}")
    end

    # Revisa el input del usuario para los métodos de ordenamiento. Ordena según
    # el +nombre+ por default.
    def metodo_de_ordenamiento
      %w[ nombre simbolo descripcion cantidad_de_perfiles
        ].include?(params[:por]) ? params[:por] : 'nombre'
    end

    # Para los mensajes del flash de responders
    def interpolation_options
      { el_la: 'la' }
    end
end
